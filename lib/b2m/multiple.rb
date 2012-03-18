module B2m
	class Multiple
		def initialize name, value, product
			@name    = name
			@value   = value
      @product = product
		end

		def value
      [ @value, @product.attribute_value("2nd #{@name}") ].compact.join ','
		end
	end
end
