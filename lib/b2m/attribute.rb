require 'ostruct'

module B2m
  class Attribute
    attr_reader :name, :product

    def initialize name, value, type, product
      @name    = name
      @value   = value
      @product = product
      @type    = type
    end

    def self.create(name, value, product)
      return NullAttribute.new if name.to_s.empty? or value.to_s.empty?

      type = case name
             when 'Stone', 'Material' then Multiple.new name, value, product
             when 'Modifier' then Modifier.new value
             when 'price' then Price.new value
             else OpenStruct.new value: value, product: product
             end

      new name, value, type, product
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
