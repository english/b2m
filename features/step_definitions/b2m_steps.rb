require 'yaml'

Given /^a sample catalog with just a ring item$/ do
  @xml = <<-XML
    <CATALOG>
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
    <CATALOG>
  XML
end

Given /^a full config$/ do
  B2m::Config.load(YAML.load_file('assets/b2m.yml'))
end

When /^I load the product$/ do
  @ring = B2m::Product.from_xml(@xml)
end

Then /^I should be able to inspect the products values$/ do
  @ring.attribute_value('sku').should           == '0101044'
  @ring.attribute_value('qty').should           == '1'
  @ring.attribute_value('price').should         == '795.00'
  @ring.attribute_value('special_price').should == '795.00'
  @ring.attribute_value('_categories').should   == 'Rings'
  @ring.attribute_value('description').should   == '18ct Yellow Gold Diamond Twist Ring'
end
