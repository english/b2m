require 'spec_helper'

module B2m
  describe Multiple do
    describe "with 2nd attribute set" do
      it "concatenates its value and 2nd attr value" do
        product = Product.new
        product.add_attribute '2nd Stone', 'Ruby'

        Multiple.new('Stone', 'Diamond', product).value.must_equal 'Diamond,Ruby'
      end
    end

    describe "with 2nd attribute not set" do
      it "returns just its own value" do
        product = Product.new
        Multiple.new('Stone', 'Diamond', product).value.must_equal 'Diamond'
      end
    end
  end
end
