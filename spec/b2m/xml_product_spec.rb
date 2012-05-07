require 'nokogiri'

require_relative '../../lib/b2m/xml_product'
require_relative '../../lib/b2m/config'

module B2m
	describe XMLProduct do
    let(:config) {
      double('config',
        :required_headers   => ['qty'],
        :translate_to_xml   => 'QTY',
        :translate_from_csv => 'Quantity'
      )
		}

    let(:xml) {
      Nokogiri::XML::Builder.new { |xml|
        xml.ITEM {
          xml.SUPPLREF 'ABC'
          xml.QTY '1'
        }
      }.to_xml
    }

		subject { XMLProduct.new(xml, config) }

    #it "should give me required headers" do
      #subject.required_headers.should == {'Quantity' => '1'}
    #end
	end
end
