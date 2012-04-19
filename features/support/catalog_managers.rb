module CatalogManagers
	def ecom_catalog(products)
		builder = Nokogiri::XML::Builder.new { |xml|
			xml.CATALOG do
				products.each do |product|
					xml.ITEM do
						product.each do |attribute, value| xml.send(attribute.to_sym, value) end
					end
				end
			end
		}.to_xml
	end

	def add_special_attributes(xml, products)
		doc = Nokogiri::XML(xml)
		products.each_with_index do |product, index|
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
end

World(CatalogManagers)
