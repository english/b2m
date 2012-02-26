module B2m
  class Price
    def initialize(name, value, product)
      @value = value
    end

    def value
      '%.2f' % @value
    end
  end
end
