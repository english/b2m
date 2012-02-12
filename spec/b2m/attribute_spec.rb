require 'spec_helper'

module B2m
  describe Attribute do
    let(:brand) { Attribute.create('Brand', 'Pandora') }
		before { Attribute.clear_instances! }

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

    it "keeps track of instances" do
      Attribute.create('Stone',    'Ruby')
      Attribute.create('Material', 'Gold')

      Attribute.instances.size.must_equal 2
    end

    it "finds attribute values" do
      Attribute.create('Brand', 'Pandora')
			Attribute.create('Material', 'Gold')

      Attribute.value('Brand').must_equal 'Pandora'
      Attribute.value('Material').must_equal 'Gold'

			Attribute.create('2nd Material', 'Silver')
      Attribute.value('Material').must_equal 'Gold,Silver'
    end
  end
end
