#$: << File.expand_path(File.dirname(__FILE__), '../../lib')
require 'aruba'
require_relative 'catalog_managers'

World(CatalogManagers)
