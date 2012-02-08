require 'nokogiri'

class Attribute
  attr_reader :name, :value

  def initialize(name, value)
    @name  = name
    @value = value
  end

  def self.from_xml(xml)
    if !att_desc(xml).empty? && !att_value(xml).empty?
      new(att_desc(xml), att_value(xml))
    end
  end

  private

  def self.att_desc(xml)
    xml.css('ATT-DESC').first.content
  end

  def self.att_value(xml)
    xml.css('ATT-VALUE').first.content
  end
end
