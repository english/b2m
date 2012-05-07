require 'active_support/inflector'

module B2m
  module Config
		extend self

    def initialize
      clear!
    end

    def clear!
      @data = Hash.new
    end

    def load(data)
      clear!
      @data = data

			self
    end

    def required_headers
      @data.fetch('required-headers') { [] }
    end

    def translate_to_xml(key)
      @data['translate-to-xml'].fetch(key) { key.camelize.upcase }
    end

		def translate_from_csv(key)
      @data['translate-from-csv'].fetch(key) { key.titlecase.strip }
		end
  end
end
