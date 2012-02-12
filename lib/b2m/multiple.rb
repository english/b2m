module B2m
	class Multiple
		def initialize(attribute_name, attribute_value)
			@attribute = attribute_name
			@value     = attribute_value
		end

		def value
			[ @value, Attribute.value("2nd #{@attribute}") ].compact.join(',')
		end
	end
end
