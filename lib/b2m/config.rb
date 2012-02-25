require 'singleton'

module B2m
  class Config
    include Singleton

    def initialize
      @data = NullHash.new
    end

    def setup(data)
      @data = Hash.new(NullValue.new)
      @data.merge! data
    end

    def self.setup(data)
      self.instance.setup(data)
    end

    def required_headers
      @data['required-headers']
    end

    def translate(key)
      @data['translate'][key]
    end
  end

  class NullHash
    def [](key)
      NullValue.new
    end
  end

  class NullValue
    def each; end
  end
end
