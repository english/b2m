Given /^a sample XML catalog with just one ring item$/ do
  @xml = File.read File.expand_path '../../../fixtures/ring.xml', __FILE__
end

When /^I load the product from the XML file$/ do
  @product = B2m::Product.from_xml @xml
end

Then /^the product should have the following attribute values:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    hash.each do |attribute, value|
      @product.attribute_value(attribute).should == value
    end
  end
end
