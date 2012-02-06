require 'nokogiri'

class Attribute
  attr_reader :name, :value

  def initialize(name, value)
    raise 'name and value must not be empty' if name.empty? or value.empty?
    @name  = name
    @value = value
  end

  def self.from_xml(xml)
    new(att_desc(xml), att_value(xml))
  end

  private

  def self.att_desc(xml)
    xml.css('ATT-DESC').first.content
  end

  def self.att_value(xml)
    xml.css('ATT-VALUE').first.content
  end
end
