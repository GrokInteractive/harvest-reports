module HarvestReports::Reports::Support
  class Name
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def <=>(rhs)
      @value.casecmp(rhs.value)
    end

    def to_s
      @value
    end
  end
end

