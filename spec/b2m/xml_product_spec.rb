require 'nokogiri'

require_relative '../../lib/b2m/xml_product'
require_relative '../../lib/b2m/config'

module B2m
	describe XMLProduct do
    before do
      Config.instance.load({
        'required-headers'   => %w{ condition _store qty },
        'translate-to-xml'   => {
          'Quantity' => 'QTY'
         },
        'translate-from-csv' => { 'qty' => 'Quantity' }
      })
    end

    let(:xml) {
      Nokogiri::XML::Builder.new { |xml|
        xml.ITEM {
          xml.ATTR 'A' 
          xml.STOCKNO '0101001'
          xml.SUPPLREF 'ABC'
          xml.QTY '1'
          xml.PRICE '000123.00'
          xml.NOTEPAD 'Bla bla bla'
          xml.ATTRIBUTE { 
            xml.send('ATT-DESC'.to_sym, 'Brand')
            xml.send('ATT-VALUE'.to_sym, 'Other')
          }
          xml.ATTRIBUTE { 
            xml.send('ATT-DESC'.to_sym, 'Stone')
            xml.send('ATT-VALUE'.to_sym, 'Diamond')
          }
        }
      }.to_xml
    }

		subject { XMLProduct.new xml }

    it "should give me required headers" do
      subject.required_headers.should == {'Quantity' => '1'}
    end
	end
end
