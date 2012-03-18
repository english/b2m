require 'spec_helper'

module B2m
  describe Modifier do
    it "returns Add for A, Modify for M and Delete for D" do
      Modifier.new(nil, 'A', nil).value.should == 'Add'
      Modifier.new(nil, 'M', nil).value.should == 'Modify'
      Modifier.new(nil, 'D', nil).value.should == 'Delete'
    end
  end
end
