require 'attribute'
require 'nokogiri'

class Product
  def initialize
    @attributes = []
  end

  def add_attribute(name, value)
    unless has_attribute? name
      @attributes << Attribute.new(name, value)
    end
  end

  def attribute_value(name)
    if self.respond_to? name.downcase.to_sym, :include_privates
      self.send name.downcase.to_sym
    else
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
    @attributes += xml.css('ATTRIBUTE').map {|att| Attribute.from_xml(att) }
  end

  private

  def multiple(attribute_name)
    [ @attributes.find {|attr| attr.name == attribute_name }.value,
      attribute_value("2nd #{attribute_name}") ].join ','
  end

  def stone
    multiple('Stone')
  end

  def material
    multiple('Material')
  end
end
