module B2m
  class Attribute
    attr_reader :name, :value
    @@instances = {}

    def initialize(name, value)
      @name  = name
      @value = value
    end

    def self.create(name, value)
      return nil if name.empty? or value.empty?

      if name == 'Stone'
        Stone.new(value).send(:store)
      else
        new(name, value).send(:store)
      end
    end

    def self.from_xml(xml)
      if !att_desc(xml).empty? && !att_value(xml).empty?
        new(att_desc(xml), att_value(xml))
      end
    end

    def self.value(name)
      @@instances[name].value unless @@instances[name].value.empty?
    rescue NoMethodError
    end

    def self.clear_instances!
      @@instances.clear
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
end
