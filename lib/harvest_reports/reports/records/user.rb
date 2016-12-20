module HarvestReports::Reports::Records
  class User
    def initialize(user, billable_entries, nonbillable_entries, expected_hours, summer: HarvestReports::Reports::Support::TimeEntrySummer.new)
      @user = user
      @billable_entries = billable_entries || []
      @nonbillable_entries = nonbillable_entries || []
      @summer = summer
      @expected_hours = expected_hours
    end

    def to_h
      {
        'Name' => "#{user.first_name} #{user.last_name}",
        'Rounded Billable Actualized' => rounded_billable_actualized(expected_hours),
        'Billable Actualized' => billable_actualized(expected_hours),
        'Actualized Time' => all_time_actualized(expected_hours),
        'Rounded Billable Time' => rounded_billable_time,
        'Rounded Nonbillable Time' => rounded_nonbillable_time,
        'Rounded All Time' => rounded_all_time,
        'Billable Time' => billable_time,
        'Nonbillable Time' => nonbillable_time,
        'All Time' => all_time,
      }
    end

    private

    attr_reader :user, :expected_hours, :billable_entries, :nonbillable_entries, :summer

    def rounded_billable_actualized(expected_hours)
      HarvestReports::Reports::Support::Percent.new(summer.sum_rounded_entries(billable_entries) / expected_hours.billable_hours_for_range)
    end

    def billable_actualized(expected_hours)
      HarvestReports::Reports::Support::Percent.new(summer.sum_entries(billable_entries) / expected_hours.billable_hours_for_range)
    end

    def all_time_actualized(expected_hours)
      HarvestReports::Reports::Support::Percent.new(summer.sum_entries(billable_entries + nonbillable_entries) / expected_hours.all_hours_for_range)
    end

    def rounded_billable_time
      summer.sum_rounded_entries(billable_entries)
    end

    def rounded_nonbillable_time
      summer.sum_rounded_entries(nonbillable_entries)
    end

    def rounded_all_time
      summer.sum_rounded_entries(billable_entries + nonbillable_entries)
    end

    def billable_time
      summer.sum_entries(billable_entries)
    end

    def nonbillable_time
      summer.sum_entries(nonbillable_entries)
    end

    def all_time
      summer.sum_rounded_entries(billable_entries + nonbillable_entries)
    end
  end
end
