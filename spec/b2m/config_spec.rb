require 'spec_helper'

module B2m
  describe Config do
    let(:config) do
      Config.instance.load({
        'required-headers' => %w{ condition _store qty },
        'translate' => { 'apples' => 'oranges' }
      })

      Config.instance
    end

    it "has required headers" do
      config.required_headers.must_equal %w{ condition _store qty }
    end

    it "translates bsmart attributes to magento attributes" do
      config.translate('apples').must_equal 'oranges'
    end

    it "can reload" do
      config = Config.instance
      config.load({'name' => 'A'})

      config.instance_variable_get(:@data)['name'].must_equal 'A'

      config.load({'name' => 'B'})
      config.instance_variable_get(:@data)['name'].must_equal 'B'
    end

    it "can be cleared" do
      config.required_headers.must_equal %w{ condition _store qty }
      config.clear!
      config.required_headers.must_equal []
    end
  end
end
