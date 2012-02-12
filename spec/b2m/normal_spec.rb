require 'spec_helper'

module B2m
  describe Normal do
    before { Attribute.clear_instances! }

    it "concatenates Stone and 2nd Stone" do
      Normal.new('1').value.must_equal '1'
    end
  end
end
