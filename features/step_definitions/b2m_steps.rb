Given /^a simple config file$/ do
  B2m::Config.load YAML.load_file File.expand_path '../../../fixtures/config.yml', __FILE__
end

Given /^a bsmart catalog file with the following attributes:$/ do |table|
  builder = Nokogiri::XML::Builder.new do |xml|
    xml.CATALOG do
      table.hashes.each do |product|
        xml.ITEM do
          product.each do |attribute, value|
            xml.send attribute.to_sym, value
          end
        end
      end
    end
  end
  @catalog = Nokogiri::XML(builder.to_xml)
end

Given /^the catalog has the following custom attributes:$/ do |table|
  table.hashes.each do |attributes|
    @catalog.css('ITEM').each do |item|
      attributes.each do |name, value|
        att_desc = Nokogiri::XML::Node.new 'ATT-DESC', @catalog
        att_desc.content = name
        att_value = Nokogiri::XML::Node.new 'ATT-VALUE', @catalog
        att_value.content = value
        attr = Nokogiri::XML::Node.new 'ATTRIBUTE', @catalog
        attr << att_desc
        attr << att_value
        item << attr
      end
    end
  end
end

When /^I load the product from the XML file$/ do
  @product = B2m::Product.from_xml @catalog.to_xml
end

Then /^the product should have the following attribute values:$/ do |table|
  table.hashes.each do |hash|
    hash.each do |attribute, value|
      @product.attribute_value(attribute).should == value
    end
  end
end
