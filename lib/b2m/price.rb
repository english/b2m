module B2m
  class Price
    def initialize value
      @value = value
    end

    def value
      '%.2f' % @value
    end
  end
end
