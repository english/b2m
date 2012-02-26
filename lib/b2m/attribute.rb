module B2m
  class Attribute
    attr_reader :name, :product

    def initialize(name, value, type, product)
      @name    = name
      @value   = value
      @product = product
      @type    = type.new name, value, product
    end

    def self.create(name, value, product)
      return NullAttribute.new if name.to_s.empty? or value.to_s.empty?

      type = case name
             when 'Stone'    then Multiple
             when 'Material' then Multiple
             when 'Modifier' then Modifier
             when 'price' then Price
             else Normal
             end

      new(name, value, type, product)
    end

    def self.from_xml(xml, product)
      self.create att_desc(xml), att_value(xml), product
    end

    def value
      @type.value
    end

    def to_s
      "#{@name}: #{@value}"
    end

    private

    def self.att_desc(xml)
      xml.at_css('ATT-DESC').content
    end

    def self.att_value(xml)
      xml.at_css('ATT-VALUE').content
    end
  end

  class NullAttribute
    def initialize(*args); end
    def name; end
    def value; end
    def product; end
  end
end
