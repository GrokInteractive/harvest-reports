module HarvestReports::Reports::Support
  class Sort
    OPTIONS = [
      'Name',
      'Client Name',
      'Project Name',
      'Rounded Billable Actualized',
      'Billable Actualized',
      'Actualized Time',
      'Rounded Billable Time',
      'Rounded Nonbillable Time',
      'Rounded All Time',
      'Billable Time',
      'Nonbillable Time',
      'All Time',
    ]

    def initialize(string)
      raise ArgumentError, "You must choose a valid option for sorting. Choose from #{OPTIONS.join(", ")}" unless OPTIONS.include?(string)

      @sort = string
    end

    def to_s
      @sort
    end
  end
end
