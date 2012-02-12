require 'spec_helper'

module B2m
  describe Stone do
		before(:each) { Attribute.clear_instances! }

    it "has a name and value like any other attribute" do
      stone = Attribute.create('Stone', 'Diamond')

      stone.name.must_equal  'Stone'
      stone.value.must_equal 'Diamond'
    end

    it "concatenates Stone and 2nd Stone to construct its value" do
      stone = Stone.new('Diamond')
      Attribute.create('2nd Stone', 'Ruby')

      stone.value.must_equal 'Diamond,Ruby'
    end
  end
end
