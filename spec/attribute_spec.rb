require 'spec_helper'
require 'attribute'

describe Attribute do
  let(:brand) { Attribute.new('Brand', 'Pandora') }

  it "has a name and value" do
    brand.name.must_equal  'Brand'
    brand.value.must_equal 'Pandora'
  end

  it "can be constructed from xml" do
    xml = <<-XML
      <ATTRIBUTE>
        <ATT-DESC>Brand</ATT-DESC>
        <ATT-VALUE>TechnoMarine</ATT-VALUE>
      </ATTRIBUTE>
    XML

    xml_attr = Attribute.from_xml Nokogiri::XML(xml)
    xml_attr.name.must_equal  'Brand'
    xml_attr.value.must_equal 'TechnoMarine'
  end
end
