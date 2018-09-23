module Rykn0wxx
	class ImportResult
		attr_reader :failed, :added, :updated, :header_key

		def initialize(header_key = 'id')
			@header_key = header_key.to_sym
			@failed = []
      @added = []
			@updated = []
		end

		def add(chunk)
		  @updated += chunk.select { |e| e.has_key?(@header_key) }
		  @added += chunk.reject { |e| e.has_key?(@header_key) }
		end

	end
end
