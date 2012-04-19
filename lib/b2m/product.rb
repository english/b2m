require_relative 'attribute'
require_relative 'xml_product'

module B2m
  class Product
    def initialize
      @attributes = Hash.new
      @config     = Config.instance
    end

    def self.from_xml(xml)
      product = Product.new
      product.add_attributes_from_xml(Nokogiri::XML(xml))

      product
    end

    def add_attribute(name, value)
      attr = Attribute.create(name, value, self)
      insert_attribute(attr)

			self
    end

    def attribute_value(name)
      attribute = @attributes.fetch(name) { NullAttribute.new }

			attribute.value
    end

    def attributes_count
      @attributes.keys.compact.count
    end

    def attribute?(name)
      @attributes.include?(name)
    end

    def add_attributes_from_xml(xml)
      add_required_headers(xml)
      add_from_attribute_nodes(xml)
      add_extra_attributes(xml)

			self
    end

    private

    def add_extra_attributes(xml)
      modifier = node_content(xml, 'ATTR')
      add_attribute('Modifier', modifier)

			self
    end

    def add_from_attribute_nodes(xml)
      xml.css('ATTRIBUTE').each do |node|
				name, value = Attribute.att_desc(node), Attribute.att_value(node)
				add_attribute(name, value)

				self
      end
    end

    def add_required_headers(xml)
      xml_product = XMLProduct.new(xml.to_xml)
      xml_product.required_headers.each do |name, value|
        add_attribute(name, value)
      end

			self
    end

    def node_content(xml, element)
      xml.at_css(element).content if xml.at_css(element)
    end

    def insert_attribute(attr)
      @attributes[attr.name] = attr unless attribute?(attr.name)

			self
    end
  end
end
