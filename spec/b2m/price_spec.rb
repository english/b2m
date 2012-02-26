require 'spec_helper'

module B2m
  describe Price do
    describe "with no special price or rrp" do
      it "concatenates its value and 2nd attr value" do
        product = Product.new
        Price.new(nil, '0000795.00', product).value.must_equal '795.00'
      end
    end
  end
end
