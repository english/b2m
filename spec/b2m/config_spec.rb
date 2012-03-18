require 'spec_helper'

module B2m
  describe Config do
    subject do
      Config.instance.load({
        'required-headers'   => %w{ condition _store qty },
        'translate-to-xml'   => {
          'apples' => 'oranges',
          'Supplier Reference' => 'SUPPLREF'
         },
        'translate-from-csv' => { 'qty' => 'Quantity' }
      })

      Config.instance
    end

    its(:required_headers) { should ==  %w{ condition _store qty } }

    describe :translate_to_xml do
      it "translates human readable attribute names to bsmart xml names" do
        subject.translate_to_xml('apples').should == 'oranges'
        subject.translate_to_xml('Supplier Reference').should == 'SUPPLREF'
      end

      it "returns the attribute upcased and without leading underscore if not specified" do
        subject.translate_to_xml('Qty').should == 'QTY'
      end
    end

    describe :translate_from_csv do
      it "translates magento csv names to human readable attribute names" do
        subject.translate_from_csv('qty').should == 'Quantity'
      end

      it "returns the attribute sentence cased if not specified" do
        subject.translate_from_csv('_hey_brah').should == 'Hey Brah'
      end
    end

    it "can reload" do
      subject.load({'name' => 'A'})

      subject.instance_variable_get(:@data)['name'].should == 'A'

      subject.load({'name' => 'B'})
      subject.instance_variable_get(:@data)['name'].should == 'B'
    end

    it "can be cleared" do
      subject.required_headers.should == %w{ condition _store qty }
      subject.clear!
      subject.required_headers.should be_empty
    end
  end
end
