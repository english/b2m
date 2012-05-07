require 'active_support/inflector'

module B2m
  module Config
		extend self

    def clear!
      @data = {}
    end

    def load(data)
      clear!
      @data = data

			self
    end

    def required_headers
      data.fetch('required-headers') { [] }
    end

    def translate_to_xml(key)
      data['translate-to-xml'].fetch(key) { key.camelize.upcase }
    end

		def translate_from_csv(key)
      data['translate-from-csv'].fetch(key) { key.titlecase.strip }
		end

		private

		def data
			@data ||= {}
		end
  end
end
