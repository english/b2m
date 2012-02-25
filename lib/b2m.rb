$:.unshift(File.expand_path(File.dirname(__FILE__)))

module B2m
  require 'nokogiri'

  require 'b2m/config'
  require 'b2m/attribute'
  require 'b2m/multiple'
  require 'b2m/modifier'
  require 'b2m/normal'
  require 'b2m/product'
end
