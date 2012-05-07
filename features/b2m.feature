Feature: Load products from an xml file

  So that I can do anything with the bsmart stock file
  As the developer 
  I want to be able to work with an object of that product

  Scenario: Loaded product has simple attribute values
    Given a simple config file
    And a bsmart ecom catalog named "catalog.xml" with the following attributes:
       | ATTR     | A                                   | 
       | STKNO    | 101044                              | 
       | SUPPLREF | ML99/35                             | 
       | QTY      | 1                                   | 
       | PRICE    | 0000795                             | 
       | REASON   |                                     | 
       | CATEGORY | 1                                   | 
       | WEBDESC  | 18ct Yellow Gold Diamond Twist Ring | 
       | NOTEPAD  | Round brilliant diamond ring.       | 

    And the ecom catalog "catalog.xml" has the following custom attributes:
       | Brand         | Other        | 
       | Stone         | Diamond      | 
       | 2nd Stone     |              | 
       | Stone Cut     |              | 
       | Stone Setting |              | 
       | Gender        | Ladies       | 
       | Material      | Yellow Gold  | 
       | 2nd Material  |              | 
       | Ring Type     | Engagement   | 
       | Ring Type 2   | Single Stone | 
       | Ring Type 3   |              | 
       | Total Weight  | 0.00         | 

    When I load the product from the bsmart ecom catalog "catalog.xml"
    Then the product should have the following attribute values:
      | Modifier | SKU     | Supplier Reference | Quantity | Price  | Name                                | Description                                                                                                                | 
      | Add      | 0101044 |                    | 1        | 795.00 | 18ct Yellow Gold Diamond Twist Ring | The round brilliant diamond is set in a soft curved mount creating a rub over setting, completing this stylish twist ring. | 
