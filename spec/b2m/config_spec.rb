require 'spec_helper'

module B2m
  describe Config do
    subject do
      Config.instance.load({
        'required-headers'   => %w{ condition _store qty },
        'translate-to-xml'   => { 'apples' => 'oranges' },
        'translate-from-csv' => { 'qty' => 'Quantity' }
      })

      Config.instance
    end

    its(:required_headers) { should ==  %w{ condition _store qty } }

    it "translates human readable attribute names to bsmart xml names" do
      subject.translate_to_xml('apples').should == 'oranges'
    end

    it "translates magento csv names to human readable attribute names" do
      subject.translate_from_csv('qty').should == 'Quantity'
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
