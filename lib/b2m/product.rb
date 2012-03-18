module B2m
  class Product
    def initialize
      @attributes = Hash.new NullAttribute.new
      @config = Config.instance
    end

    def self.from_xml xml
      product = Product.new
      product.add_attributes_from_xml Nokogiri::XML xml

      product
    end

    def add_attribute name, value
      attr = Attribute.create name, value, self
      @attributes[attr.name] = attr unless attribute? attr.name
    end

    def attribute_value name
      @attributes[name].value
    end

    def attributes_count
      @attributes.keys.compact.count
    end

    def attribute? name
      @attributes.include? name
    end

    def add_attributes_from_xml xml
      add_required_headers xml
      add_from_attribute_nodes xml
    end

    private

    def add_from_attribute_nodes xml
      xml.css('ATTRIBUTE').each do |att|
        attribute = Attribute.from_xml att, self
        add_attribute attribute.name, attribute.value
      end
    end

    def add_required_headers xml
      @config.required_headers.each do |header|
        nice_name = @config.translate_from_csv header
        xml_name = @config.translate_to_xml nice_name
        add_attribute nice_name, node_content(xml, xml_name)
      end
    end

    def node_content xml, element
      xml.at_css(element).content if xml.at_css element
    end
  end
end
