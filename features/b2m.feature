Feature: Load import stock from bsmart to Magento

  In order to keep website stock up to date
  As a stock administrator
  I want to run a command on the command line to update the stock

  Scenario: Load a product from sample ring xml
    Given a sample catalog with just a ring item
    And a full config
    When I load the product
    Then I should be able to inspect the products values
