require 'spec_helper'

module B2m
  describe Attribute do
    it "has a name, value and a product" do
      product = Product.new
      brand = Attribute.create 'Brand', 'Pandora', product

      brand.name.must_equal  'Brand'
      brand.value.must_equal 'Pandora'
      brand.product.must_be_same_as product
    end

    it "can be constructed from xml" do
      xml = <<-XML
        <ATTRIBUTE>
          <ATT-DESC>Brand</ATT-DESC>
          <ATT-VALUE>TechnoMarine</ATT-VALUE>
        </ATTRIBUTE>
      XML

      xml_attr = Attribute.from_xml Nokogiri::XML(xml), Product.new
      xml_attr.name.must_equal  'Brand'
      xml_attr.value.must_equal 'TechnoMarine'
    end
  end
end
