module HarvestReports::Reports::Records
  class Project
    def initialize(project, billable_entries, nonbillable_entries, summer: HarvestReports::Reports::Support::TimeEntrySummer.new)
      @project = project
      @billable_entries = billable_entries || []
      @nonbillable_entries = nonbillable_entries || []
      @summer = summer
      @expected_hours = expected_hours
    end

    def to_h
      {
        'Client Name' =>  HarvestReports::Reports::Support::Name.new(project.client.name),
        'Project Name' =>  HarvestReports::Reports::Support::Name.new(project.name),
        'Rounded Billable Time' => summer.sum_rounded_entries(billable_entries),
        'Rounded Nonbillable Time' => summer.sum_rounded_entries(nonbillable_entries),
        'Rounded All Time' => summer.sum_rounded_entries(billable_entries + nonbillable_entries),
        'Billable Time' => summer.sum_entries(billable_entries),
        'Nonbillable Time' => summer.sum_entries(nonbillable_entries),
        'All Time' => summer.sum_rounded_entries(billable_entries + nonbillable_entries),
      }
    end

    private

    attr_reader :project, :expected_hours, :billable_entries, :nonbillable_entries, :summer

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
