require 'spec_helper'

module B2m
  describe Multiple do
		before { Attribute.clear_instances! }

    it "concatenates Stone and 2nd Stone" do
			stone        = Attribute.create('Stone', 'Diamond')
			second_stone = Attribute.create('2nd Stone', 'Ruby')

			Multiple.new('Stone', 'Diamond').value.must_equal 'Diamond,Ruby'
    end
  end
end
