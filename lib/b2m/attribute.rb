module B2m
  class Attribute
    attr_reader :name, :product

    def initialize(name, value, type, product)
      @name    = name
      @value   = value
      @type    = type
      @product = product
    end

    def self.create(name, value, product)
      return NullAttribute.new if name.to_s.empty? or value.to_s.empty?

      type = case name
             when 'Stone'    then Multiple.new 'Stone',    value, product
             when 'Material' then Multiple.new 'Material', value, product
             when 'Modifier' then Modifier.new value
             else Normal.new value
             end

      attribute = new(name, value, type, product)
    end

    def self.from_xml(xml, product)
      self.create att_desc(xml), att_value(xml), product
    end

    def value
      @type.value
    end

    private

    def self.att_desc(xml)
      xml.css('ATT-DESC').first.content
    end

    def self.att_value(xml)
      xml.css('ATT-VALUE').first.content
    end
  end

  class NullAttribute
    def initialize(*args); end
    def name; end
    def value; end
    def product; end
  end
end
