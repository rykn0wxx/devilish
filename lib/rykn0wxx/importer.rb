module Rykn0wxx
	class Importer

		attr_reader :resource, :options, :result, :csv_file #csv_obj
		attr_accessor :chunks, :headers

		def initialize(resource = nil, csv_file = nil)
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
			batch_for_update = chunk.select { |e| e.has_key?(@header_key) }
			import_result.add(batch_process(chunk))
			puts batch_for_update if batch_for_update.any?
		end

		def import
		  process_file
			import_result
		end

		protected

		def process_file
			SmarterCSV.process(file.path, assigned_options) do |chunk|
				worker(chunk)
			end
		end

		def batch_process(chunk)
			batch_result = nil
			batch_added = to_be_added(chunk)
			batch_headers = batch_added.map { |e| e.keys }.uniq.first
			batch_headers.delete(:id)
		  ActiveRecord::Base.connection.reconnect!
			batch_result = @resource.import(batch_headers, batch_added, :validate => true)
			raise ActiveRecord::Rollback if batch_result.failed_instances.any?
			[batch_result, batch_added]
		end

		def to_be_added(chunk)
		  chunk.reject { |e| e.has_key?(@header_key) }
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
