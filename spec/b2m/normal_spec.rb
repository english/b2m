require 'spec_helper'

module B2m
  describe Normal do
    it "concatenates Stone and 2nd Stone" do
      Normal.new(nil, '1', nil).value.must_equal '1'
    end
  end
end
