require 'spec_helper'

module B2m
  describe Material do
    it "joins multiple values together if others exist" do
      material        = Attribute.create('Material', 'Gold')
      second_material = Attribute.create('2nd Material', 'Silver')

      material.value.must_equal 'Gold,Silver'
    end
  end
end
