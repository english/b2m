require 'singleton'

module B2m
  class Config
    include Singleton

    def initialize
      clear!
    end

    def clear!
      @data = Hash.new []
    end

    def self.clear!
      self.instance.clear!
    end

    def load data
      clear!
      @data.merge! data
    end

    def self.load data
      self.instance.load data
    end

    def required_headers
      @data['required-headers']
    end

    def translate_to_xml key
      @data['translate-to-xml'][key]
    end

		def translate_from_csv key
      @data['translate-from-csv'][key]
		end
  end
end
