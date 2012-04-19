require 'nokogiri'

module B2m
  class XMLProduct
    def initialize(xml)
      @doc = Nokogiri::XML(xml)
      @config = Config.instance
    end

    def required_headers
      @config.required_headers.each_with_object({}) { |header, result|
        nice_name = @config.translate_from_csv(header)
        xml_name  = @config.translate_to_xml(nice_name)
        val       = node_value(xml_name)

        result[nice_name] = val unless val.nil?
      }
    end

    private

    def node_value(element)
      @doc.at_css(element).content if @doc.at_css(element)
    end
  end
end
