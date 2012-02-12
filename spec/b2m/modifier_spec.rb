require 'spec_helper'

module B2m
  describe Modifier do
    it "returns Add for A, Modify for M and Delete for D" do
      Modifier.new('A').value.must_equal 'Add'
      Modifier.new('M').value.must_equal 'Modify'
      Modifier.new('D').value.must_equal 'Delete'
    end
  end
end
