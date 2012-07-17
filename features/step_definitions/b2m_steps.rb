require 'aruba/cucumber'
require 'csv'

require_relative '../../lib/b2m/product'

Given /^a bsmart catalog named "(.*?)" with the following attributes:$/ do |filename, product_table|
  xml = ecom_catalog_vertical product_table
  write_file filename, xml
end

Then /^I should see the following CSV:$/ do |table|
  actual = CSV.parse all_output
  table.diff! actual
end
