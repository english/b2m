require_relative '../../lib/b2m/catalog'
require_relative '../../features/support/catalog_managers'

include CatalogManagers

module B2m
	describe Catalog do
		describe "Catalog.from_xml" do
			it "creates a catalog instance from an xml file" do
				xml = ecom_catalog [{ "ATTR" => "A", "STKNO" => "0101044" }]

				subject = Catalog.from_xml xml

				subject.products.size.should == 1
			end
		end
	end
end
