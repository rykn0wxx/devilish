module Rykn0wxx
	class Importer

		attr_reader :resource, :options, :result, :csv_file #csv_obj
		attr_accessor :chunks, :headers

		def initialize(resource, csv_file)
		  @resource = resource
			@csv_file = csv_file
		end

		def import_result
		  @import_result ||= ImportResult.new('id')
		end

		def file
		  @csv_file.tempfile
		end

		def worker(chunk)
			import_result.add(chunk)
			batch_process
			batch_update if import_result.updated.any?
		end

		def import
		  process_file
			import_result
		end

		protected

		def process_file
		  @chunks = SmarterCSV.process(file.path, assigned_options)
			Parallel.map(chunks) do |chunk|
				worker(chunk)
			end
		end

		def batch_update
			batch_to_update = import_result.updated
			update_items = batch_to_update.map do |i|
				tmp_id = i[import_result.header_key].to_s
				i.delete(import_result.header_key)
				{ tmp_id =>  i }
			end.first
			batch_result = nil
			@resource.transaction do
				batch_result = resource.update(update_items.keys, update_items.values)
				# raise ActiveRecord::Rollback if batch_result.failed_instances.any?
			end
			batch_result
		end

		def batch_process
			batch_result = nil
			@resource.transaction do
				batch_result = resource.import(import_result.added, { :validate => true })
				raise ActiveRecord::Rollback if batch_result.failed_instances.any?
			end
			batch_result
		end

		def assigned_options
		  {
				:strip_chars_from_headers => /[\-"]/,
	      :chunk_size => 1000,
	      :remove_unmapped_keys => true,
	      :verbose => true
			}
		end

	end
end
