module Rykn0wxx
	class ImportResult
		attr_reader :failed, :processed, :header_key

		def initialize(header_key = 'id')
			@header_key = header_key.to_sym
			@failed = []
      @processed = []
		end

		def add(chunk)
			@failed += chunk[0].failed_instances
		  @processed += chunk[1]
		end

	end
end
