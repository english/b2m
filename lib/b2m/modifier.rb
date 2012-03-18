module B2m
  class Modifier
    def initialize value
      @value = value
    end

    def value
      case @value
      when 'A' then 'Add'
      when 'M' then 'Modify'
      when 'D' then 'Delete'
      else raise 'Incorrect Modifier Type'
      end
    end
  end
end
