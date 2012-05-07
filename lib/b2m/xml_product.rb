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

		def value
			@xml.at_css(Config.translate_to_xml(@name)).content
		rescue NoMethodError
			""
		end
	end

  class XMLProduct
		EXTRAS = %w[Modifier]

    def initialize(xml, config=Config)
      @doc = Nokogiri::XML(xml)
      @config = config
    end

		def attributes
			required_headers + custom_attributes + extra_attributes
		end

    private

    def required_headers
      @config.required_headers.map { |header|
				nice_name = Config.translate_from_csv(header)

				XMLSimpleAttribute.new(@doc, nice_name)
      }
    end

    def custom_attributes
      @doc.css('ATTRIBUTE').map { |node| XMLCustomAttribute.new(node) }
    end

    def extra_attributes
			EXTRAS.map { |nice_name| XMLSimpleAttribute.new(@doc, nice_name) }
    end
  end
end
