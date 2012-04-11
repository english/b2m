Feature: Load products from an xml file

  So that I can do anything with the bsmart stock file
  As the developer 
  I want to be able to work with an object of that product

  Scenario: Loaded product has simple attribute values
    Given a simple config file
    And a bsmart catalog file with the following attributes:
      | ATTR | STKNO   | SUPPLREF | QTY | PRICE      | REASON | CATEGORY | WEBDESC                             | NOTEPAD                                                                                                                    | 
      | A    | 0101044 | ML99/25  | 1   | 0000795.00 |        | 1        | 18ct Yellow Gold Diamond Twist Ring | The round brilliant diamond is set in a soft curved mount creating a rub over setting, completing this stylish twist ring. | 
    And the catalog has the following custom attributes:
      | Brand | Stone Cut | Stone   | Stone Setting | Gender | Material    | 2nd Material | Ring Type 2  | Ring Type 3 | Ring Type  | 2nd Stone | Total Weight | 
      | Other |           | Diamond |               | Ladies | Yellow Gold |              | Single Stone |             | Engagement |           | 0.00         | 
    When I load the product from the XML file
    Then the product should have the following attribute values:
      | Modifier | SKU     | Supplier Reference | Quantity | Price  | Name                                | Description                                                                                                                | 
      | Add      | 0101044 |                    | 1        | 795.00 | 18ct Yellow Gold Diamond Twist Ring | The round brilliant diamond is set in a soft curved mount creating a rub over setting, completing this stylish twist ring. | 
