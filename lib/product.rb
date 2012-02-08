require 'attribute'
require 'nokogiri'

class Product
  def initialize
    @attributes = []
  end

  def self.from_xml(xml)
    product = Product.new

    product_node = Nokogiri::XML(xml)
    product.add_attributes_from_xml product_node

    product
  end

  def add_attribute(name, value)
    unless has_attribute? name
      @attributes << Attribute.new(name, value)
    end
  end

  def attribute_value(name)
    if self.respond_to? name.downcase.to_sym, :include_privates
      self.send name.downcase.to_sym
    elsif has_attribute?(name)
      @attributes.find {|attr| attr.name == name }.value
    end
  end

  def attributes_count
    @attributes.size
  end

  def has_attribute?(name)
    @attributes.any? {|attr| attr.name == name }
  end

  def add_attributes_from_xml(xml)
    @attributes += xml.css('ATTRIBUTE').map {|att| Attribute.from_xml(att) }.compact
  end

  private

  def multiple(attribute_name)
    [ @attributes.find {|attr| attr.name == attribute_name }.value,
      attribute_value("2nd #{attribute_name}") ].compact.join(',')
  end

  def stone
    multiple('Stone')
  end

  def material
    multiple('Material')
  end
end
