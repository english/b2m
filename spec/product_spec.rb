require 'spec_helper'
require 'product'

describe Product do
  it "has attributes" do
    product = Product.new
    product.add_attribute 'Brand', 'Pandora'

    product.attribute_value('Brand').must_equal 'Pandora'
  end

  it "only has one attribute per attribute name" do
    product = Product.new
    product.add_attribute 'Brand', 'Pandora'
    product.add_attribute 'Brand', 'Georg Jensen'

    product.attributes_count.must_equal 1
  end

  it "can add multiple attributes from xml" do
    xml = <<-XML
      <ITEM>
        <ATTRIBUTE>
          <ATT-DESC>Brand</ATT-DESC>
          <ATT-VALUE>TechnoMarine</ATT-VALUE>
        </ATTRIBUTE>
        <ATTRIBUTE>
          <ATT-DESC>Collection</ATT-DESC>
          <ATT-VALUE>Cruise Sport</ATT-VALUE>
        </ATTRIBUTE>
      </ITEM>
    XML

    watch = Product.new
    watch.add_attributes_from_xml Nokogiri::XML(xml)

    watch.attributes_count.must_equal 2

    watch.attribute_value('Brand').must_equal      'TechnoMarine'
    watch.attribute_value('Collection').must_equal 'Cruise Sport'
  end

  it "joins attributes with multiple values" do
    ring = Product.new
    ring.add_attribute 'Stone',     'Diamond'
    ring.add_attribute '2nd Stone', 'Ruby'

    ring.attribute_value('Stone').must_equal 'Diamond,Ruby'

    ring.add_attribute 'Material',     'Silver'
    ring.add_attribute '2nd Material', 'Gold'

    ring.attribute_value('Material').must_equal 'Silver,Gold'
  end
end
