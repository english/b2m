require_relative 'attribute'
require_relative 'xml_product'

module B2m
  class Product
    def initialize
      @attributes = Hash.new
    end

    def self.from_xml(xml)
			product = Product.new.tap do |p|
        XMLProduct.new(xml).attributes.each do |attr|
          p.add_attribute(attr.name, attr.value)
        end
      end
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

    private

    def insert_attribute(attr)
      @attributes[attr.name] = attr unless attribute?(attr.name)

			self
    end
  end
end
