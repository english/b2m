Feature: Generate CSV

  So that the website has the correct stock information
  As someone with too much time on their hands
  I want to generate a CSV file that Magento can import from a bsmart XML catalog

  Scenario: Minimal XML catalog
    Given a bsmart catalog named "catalog.xml" with the following attributes:
      | ATTR     | A        |
      | STKNO    | 0101044  |
      | SUPPLREF | ML99/35  |
      | QTY      | 1        |
      | PRICE    | 0000795  |
      | REASON   |          |
      | CATEGORY | 1        |
      | WEBDESC  | 18ct Yellow Gold Ring | 
      | NOTEPAD  | Round brilliant diamond ring. | 
    When I run `b2m catalog.xml`
    Then I should see the following CSV:
      | status | Enabled |
      | SKU    | 0101044 |
      | Supplier Reference | |
      | Quantity | 1      | 
      | Price    | 795.00 | 
      | Name        | 18ct Yellow Gold Ring | 
      | Description | Round brilliant diamond ring. | 
