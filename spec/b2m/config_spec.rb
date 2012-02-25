require 'spec_helper'

module B2m
  describe Config do
    let(:config) do
      Config.new({
        'required-headers' => %w{ condition _store qty }
      })
    end

    it "has required headers" do
      config.required_headers.must_equal %w{ condition _store qty }
    end
  end
end
