require 'nokogiri'

module CatalogManagers
  def ecom_catalog_vertical(product_table)
    product = Hash[product_table.raw]

    ecom_catalog([product])
  end

	def ecom_catalog(products)
		Nokogiri::XML::Builder.new { |xml|
			xml.CATALOG do
				products.each do |product|
					xml.ITEM do
						product.each do |attribute, value| xml.send(attribute.to_sym, value) end
					end
				end
			end
		}.to_xml
	end

	def add_special_attributes(xml, products_table)
    products = [ Hash[products_table.raw] ]

		doc = Nokogiri::XML(xml)
		products.each_with_index do |product, index|
      puts product
			item = doc.css("ITEM")[index]
			product.each do |attr_name, value|
				attribute = Nokogiri::XML::Node.new('ATTRIBUTE', doc)
				att_desc  = Nokogiri::XML::Node.new('ATT-DESC', doc)
				att_value = Nokogiri::XML::Node.new('ATT-VALUE', doc)

				att_desc.content  = attr_name
				att_value.content = value

				attribute << att_desc
				attribute << att_value

				item << attribute
			end
		end

		doc.to_xml
	end

  def product_diff_vertical_table!(product, table)
    Hash[table.raw].each do |attribute, value|
      product.attribute_value(attribute).should == value
    end
  end
end
