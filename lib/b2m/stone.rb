module B2m
  class Stone < Attribute
    def initialize(value)
      super('Stone', value)
    end

    def value
      [ @value, Attribute.value('2nd Stone') ].compact.join(',')
    end
  end
end
