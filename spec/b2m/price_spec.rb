require 'spec_helper'

module B2m
  describe Price do
    context "with no special price or rrp" do
      it "concatenates its value and 2nd attr value" do
        Price.new('0000795.00').value.should == '795.00'
      end
    end
  end
end
