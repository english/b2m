require 'nokogiri'

module B2m
	class XMLCustomAttribute
		def initialize(xml)
			@xml = xml
		end

		def name
      @xml.at_css('ATT-DESC').content
		end

		def value
      @xml.at_css('ATT-VALUE').content
		end
	end

	class XMLSimpleAttribute
		attr_reader :name

		def initialize(xml, name)
			@xml = xml
			@name = name
		end
	end

  class XMLProduct
		EXTRAS = %w[Modifier]

    def initialize(xml)
      @doc = Nokogiri::XML(xml)
    end

		def attributes
      @doc.map do |node|
        Attribute.from_xml node.to_xml
      end
		end
  end
end
