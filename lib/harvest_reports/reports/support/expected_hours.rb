require 'business_time'

module HarvestReports::Reports::Support
  class ExpectedHours
    def initialize(date_range)
      @date_range = date_range

      validate_range_argument
    end

    def all_hours_for_range
      start_date.business_days_until(end_date) * 8
    end

    def billable_hours_for_range
      all_hours_for_range - number_of_fridays * 8
    end

    private

    def start_date
      @date_range.to_range.first
    end

    def end_date
      @date_range.to_range.last + 1
    end

    def number_of_fridays
      @date_range.to_range.select { |date| date.friday? && not_holiday?(date) }.count
    end

    def not_holiday?(date)
      !BusinessTime::Config.holidays.include?(date)
    end

    def validate_range_argument
      raise ArgumentError, "Must be a FormattedDateRange" unless @date_range.is_a?(FormattedDateRange)
    end

    # Configure Holidays
    YAML.load_file('./config/holidays.yml').fetch('holidays').each do |holiday|
      BusinessTime::Config.holidays << Date.parse(holiday)
    end
  end
end
