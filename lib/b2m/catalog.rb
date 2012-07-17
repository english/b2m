require 'nokogiri'
require 'b2m/product'

module B2m
  class Catalog
		attr_reader :products

    def self.from_xml xml
			doc = Nokogiri::XML(xml)

			new.tap do |cat|
				doc.css("ITEM").each do |item|
					cat << Product.from_xml(item.to_xml)
				end
			end
    end

		def add_product product
			products << product
		end
		alias :<< add_product

    def to_csv

    end
		
		def products
			@products ||= []
		end
  end
end
