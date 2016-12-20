module HarvestReports::Reports::Support
  class Percent
    attr_reader :value

    def initialize(value)
      @value = value
    end

    def <=>(rhs)
      @value <=> rhs.value
    end

    def to_s
      sprintf('%.2f%', @value * 100)
    end
  end
end

