module B2m
	class Material < Attribute
		def initialize(value)
			super('Material', value)
		end

		def value
			[ @value, Attribute.value('2nd Material') ].compact.join(',')
		end
	end
end
