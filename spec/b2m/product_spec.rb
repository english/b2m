require 'spec_helper'

module B2m
  describe Product do
    it "has attributes" do
      product = Product.new
      product.add_attribute 'Brand',     'Pandora'
      product.add_attribute 'Stone',     'Diamond'
      product.add_attribute '2nd Stone', 'Ruby'
      product.add_attribute 'Material',  'Gold'

      product.attribute_value('Brand').should    == 'Pandora'
      product.attribute_value('Stone').should    == 'Diamond,Ruby'
      product.attribute_value('Material').should == 'Gold'
    end

    it "only has one attribute per attribute name" do
      subject = Product.new
      subject.add_attribute 'Brand', 'Pandora'
      subject.add_attribute 'Brand', 'Georg Jensen'

      subject.attributes_count.should ==  1
    end

    it "can add multiple attributes from xml" do
      xml = <<-XML
        <ITEM>
          <ATTRIBUTE>
            <ATT-DESC>Brand</ATT-DESC>
            <ATT-VALUE>TechnoMarine</ATT-VALUE>
          </ATTRIBUTE>
          <ATTRIBUTE>
            <ATT-DESC>Collection</ATT-DESC>
            <ATT-VALUE>Cruise Sport</ATT-VALUE>
          </ATTRIBUTE>
          <ATTRIBUTE>
            <ATT-DESC></ATT-DESC>
            <ATT-VALUE></ATT-VALUE>
          </ATTRIBUTE>
        </ITEM>
      XML

      watch = Product.from_xml(xml)

      watch.attributes_count.should == 2

      watch.attribute_value('Brand').should      == 'TechnoMarine'
      watch.attribute_value('Collection').should == 'Cruise Sport'
    end

    describe "attributes that can have multiple values" do
      it "joins attributes with multiple values" do
        ring = Product.new
        ring.add_attribute 'Stone',     'Diamond'
        ring.add_attribute '2nd Stone', 'Ruby'

        ring.attribute_value('Stone').should == 'Diamond,Ruby'

        ring.add_attribute 'Material',     'Silver'
        ring.add_attribute '2nd Material', 'Gold'

        ring.attribute_value('Material').should == 'Silver,Gold'
      end
    end

    describe :from_xml do
      let(:xml) do
        <<-XML
          <ITEM>
            <ATTR>A</ATTR> <STKNO>0101044</STKNO> <MENU>1</MENU> <SUBMENU>1</SUBMENU>
            <SUPPLCODE>1001</SUPPLCODE> <SUPPLSHORT>UDC</SUPPLSHORT>
            <SUPPLREF>ML99/25</SUPPLREF> <DESC>18ctYG SS Dia RO/XO</DESC>
            <QTY>1</QTY> <PRICE>0000795.00</PRICE> <REASON></REASON>
            <CATEGORY>1</CATEGORY> <WEBDESC>18ct Yellow Gold Diamond Twist Ring</WEBDESC>
            <NOTEPAD><![CDATA[The round brilliant diamond is set in a soft curved mount creating a rub over setting, completing this stylish twist ring. ]]> </NOTEPAD>
            <ATTRIBUTE>
              <ATT-TYPE>BR</ATT-TYPE> <ATT-DESC>Brand</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE>01</ATT-CODE> <ATT-VALUE>Other</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>C3</ATT-TYPE> <ATT-DESC>Stone Cut</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE></ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>C7</ATT-TYPE> <ATT-DESC>Stone</ATT-DESC> <ATT-FORMAT>T</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE>Diamond</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>C8</ATT-TYPE> <ATT-DESC>Stone Setting</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE></ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>G1</ATT-TYPE> <ATT-DESC>Gender</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE>01</ATT-CODE> <ATT-VALUE>Ladies</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>M1</ATT-TYPE> <ATT-DESC>Material</ATT-DESC> <ATT-FORMAT>T</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE>Yellow Gold</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>M2</ATT-TYPE> <ATT-DESC>2nd Material</ATT-DESC> <ATT-FORMAT>T</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE></ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>R2</ATT-TYPE> <ATT-DESC>Ring Type 2</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE>02</ATT-CODE> <ATT-VALUE>Single Stone</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>R3</ATT-TYPE> <ATT-DESC>Ring Type 3</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE></ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>RT</ATT-TYPE> <ATT-DESC>Ring Type</ATT-DESC> <ATT-FORMAT>L</ATT-FORMAT> <ATT-CODE>02</ATT-CODE> <ATT-VALUE>Engagement</ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>S2</ATT-TYPE> <ATT-DESC>2nd Stone</ATT-DESC> <ATT-FORMAT>T</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE></ATT-VALUE>
            </ATTRIBUTE>
            <ATTRIBUTE>
              <ATT-TYPE>TW</ATT-TYPE> <ATT-DESC>Total Weight</ATT-DESC> <ATT-FORMAT>V</ATT-FORMAT> <ATT-CODE></ATT-CODE> <ATT-VALUE>0.00</ATT-VALUE>
            </ATTRIBUTE>
          </ITEM>
        XML
      end

      it "loads the ATTRIBUTE nodes to attributes" do
        product = Product.from_xml xml 
        product.attribute_value('Gender').should   == 'Ladies'
        product.attribute_value('Material').should == 'Yellow Gold'
      end

      it "loads attributes specified in 'required-headers' in config" do
        Config.load({
          'required-headers' => %w[qty price sku],
          'translate-to-xml' => {
            'Quantity' => 'QTY',
            'Price'    => 'PRICE',
            'Modifier' => 'ATTR',
						'SKU'      => 'STKNO'
          },
          'translate-from-csv' => {
            'qty'   => 'Quantity',
            'price' => 'Price',
						'sku'   => 'SKU'
          }
        })

        product = Product.from_xml(xml) 
        product.attribute_value('Quantity').should == '1'
        product.attribute_value('Price').should    == '795.00'
        product.attribute_value('Modifier').should == 'Add'
        product.attribute_value('SKU').should == '0101044'
      end
    end
  end
end
