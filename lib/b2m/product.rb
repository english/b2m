module B2m
  class Product
    def initialize(config = {})
      @attributes = Hash.new(NullAttribute.new)
      @config = config
    end

    def self.from_xml(xml, config = {})
      product = Product.new(config)
      product.add_attributes_from_xml Nokogiri::XML(xml)

      product
    end

    def add_attribute(name, value)
      attr = Attribute.create name, value, self
      @attributes[attr.name] = attr unless attribute? attr.name
    end

    def attribute_value(name)
      @attributes[name].value
    end

    def attributes_count
      @attributes.keys.compact.count
    end

    def attribute?(name)
      @attributes.include? name
    end

    def add_attributes_from_xml(xml)
      add_attribute 'Stock Number', node_content(xml, 'STKNO')
      add_attribute 'Modifier',     node_content(xml, 'ATTR')
      add_attribute 'Supplier Reference', node_content(xml, 'SUPPLREF')
      add_attribute 'Quantity', node_content(xml, 'QTY')

      xml.css('ATTRIBUTE').each do |att|
        attribute = Attribute.from_xml att, self
        add_attribute(attribute.name, attribute.value)
      end
    end

    private

    def node_content(xml, element)
      xml.at_css(element).content if xml.at_css(element)
    end
  end
end
