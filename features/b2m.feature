Feature: Load products from an xml file

  So that I can do anything with the bsmart stock file
  As the developer 
  I want to be able to work with an object of that product

  Scenario: Loaded product has simple attribute values
    Given a sample XML catalog with just one ring item
    And a simple config file
    When I load the product from the XML file
    Then the product should have the following attribute values:
       | Modifier | SKU     | Supplier Reference | Quantity | Price  | Name                                | Description                                                                                                                | 
       | Add      | 0101044 |                    | 1        | 795.00 | 18ct Yellow Gold Diamond Twist Ring | The round brilliant diamond is set in a soft curved mount creating a rub over setting, completing this stylish twist ring. | 
