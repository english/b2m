require 'spec_helper'

module B2m
  describe Modifier do
    it "returns Add for A, Modify for M and Delete for D" do
      Modifier.new('A').value.should == 'Add'
      Modifier.new('M').value.should == 'Modify'
      Modifier.new('D').value.should == 'Delete'
    end
  end
end
