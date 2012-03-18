require 'spec_helper'

module B2m
  describe Attribute do
    describe :create do
      let(:product) { double 'Product' }
      subject { Attribute.create 'Brand', 'Pandora', product }

      its(:name)    { should == 'Brand'    }
      its(:value)   { should == 'Pandora'  }
      its(:product) { should equal product }
    end

    describe :from_xml do
      let(:xml) { <<-XML
          <ATTRIBUTE>
            <ATT-DESC>Brand</ATT-DESC>
            <ATT-VALUE>TechnoMarine</ATT-VALUE>
          </ATTRIBUTE>
        XML
      }

      subject { Attribute.from_xml Nokogiri::XML(xml), double('Product') }
      its(:name)  { should == 'Brand'        }
      its(:value) { should == 'TechnoMarine' }
    end

    describe :value do
      context "simple attributes" do
        subject { Attribute.create 'Simple', 'answer', double('Product') }
        its(:value) { should == 'answer' }
      end

      context "A Modifier attribute" do
        context "with a value of 'A'" do
          subject { Attribute.create 'Modifier', 'A', double('Product') }
          its(:value) { should == 'Add' }
        end
      end
    end
  end
end
