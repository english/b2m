module B2m
  class Config
    def initialize(data)
      @data = data
    end

    def required_headers
      @data['required-headers']
    end
  end
end
