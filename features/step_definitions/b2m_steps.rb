require 'aruba/cucumber'
require 'nokogiri'

require_relative '../../lib/b2m/config'
require_relative '../../lib/b2m/product'

Given /^a simple config file$/ do
  yaml = YAML.load_file(File.expand_path('../../../fixtures/config.yml', __FILE__))
  B2m::Config.load(yaml)
end

Given /^a bsmart ecom catalog named "([^"]*)" with the following attributes:$/ do |filename, products_table|
  xml = ecom_catalog_vertical(products_table)
  write_file(filename, xml)
end

Given /^the ecom catalog "([^"]*)" has the following custom attributes:$/ do |filename, products_table|
  in_current_dir do
    xml = IO.read(filename)
    new_xml = add_special_attributes(xml, products_table)
    write_file(filename, new_xml)
  end
end

When /^I load the product from the bsmart ecom catalog "([^"]*)"$/ do |filename|
  in_current_dir do
    @product = B2m::Product.from_xml(File.read(filename))
  end
end

Then /^the product should have the following attribute values:$/ do |table|
  table.hashes.each do |hash|
    hash.each do |attribute, value|
      @product.attribute_value(attribute).should == value
    end
  end
end
