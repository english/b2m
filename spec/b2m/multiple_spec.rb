require 'spec_helper'

module B2m
  describe Multiple do
    context "with 2nd attribute set" do
      it "concatenates its value and 2nd attr value" do
        product = Product.new
        product.add_attribute '2nd Stone', 'Ruby'

        Multiple.new('Stone', 'Diamond', product).value.should == 'Diamond,Ruby'
      end
    end

    context "with 2nd attribute not set" do
      it "returns just its own value" do
        product = Product.new
        Multiple.new('Stone', 'Diamond', product).value.should == 'Diamond'
      end
    end
  end
end
