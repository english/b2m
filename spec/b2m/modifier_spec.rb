require 'spec_helper'

module B2m
  describe Modifier do
    it "returns Add for A, Modify for M and Delete for D" do
      Modifier.new(nil, 'A', nil).value.must_equal 'Add'
      Modifier.new(nil, 'M', nil).value.must_equal 'Modify'
      Modifier.new(nil, 'D', nil).value.must_equal 'Delete'
    end
  end
end
