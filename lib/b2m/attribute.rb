module B2m
  class Attribute
    attr_reader :name
    @@instances = {}

    def initialize(name, value, type)
      @name  = name
      @value = value
      @type  = type
    end

    def self.create(name, value)
      return NullAttribute.new if name.to_s.empty? or value.to_s.empty?

      type = case name
             when 'Stone'    then Multiple.new 'Stone',    value
             when 'Material' then Multiple.new 'Material', value
             when 'Modifier' then Modifier.new value
             else Normal.new value
             end

      attribute = new(name, value, type)
      attribute.send(:store)
    end

    def self.from_xml(xml)
      if !att_desc(xml).empty? && !att_value(xml).empty?
        self.create(att_desc(xml), att_value(xml))
      else
        NullAttribute.new
      end
    end

    def self.value(name)
      @@instances[name].value unless @@instances[name].value.empty?
    rescue NoMethodError
    end

    def self.clear_instances!
      @@instances.clear
    end

    def value
      @type.value
    end

    private

    def store
      @@instances[name] = self; self
    end

    def self.instances
      @@instances
    end

    def self.att_desc(xml)
      xml.css('ATT-DESC').first.content
    end

    def self.att_value(xml)
      xml.css('ATT-VALUE').first.content
    end
  end

  class NullAttribute
    def initialize(*args); end
    def name; end
    def value; end
  end
end
