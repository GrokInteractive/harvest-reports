module HarvestReports::Reports
  class ProjectReport
    def report(date_range: FormattedDateRange.new(Date.today), sort:, renderer:)
      billable_entries = TimeEntry.billable_entries.select { |entry| date_range.in_range?(entry.date) }.group_by { |entry| entry.project_id }
      nonbillable_entries = TimeEntry.nonbillable_entries.select { |entry| date_range.in_range?(entry.date) }.group_by { |entry| entry.project_id }
      expected_hours = ExpectedHours.new(date_range)

      projects = projects_from(billable_entries, nonbillable_entries)

      projects.map! do |project|
        HarvestReports::Reports::Records::Project.new(project, billable_entries[project.id], nonbillable_entries[project.id]).to_h
      end

      HarvestReports::Reports::Records::Collection.new(records: projects, expected_hours: expected_hours, sort: sort).render(renderer)
    end

    private

    def projects_from(billable_entries, nonbillable_entries)
      (billable_entries.keys + nonbillable_entries.keys).map { |id| Project.find(id) }
    end
  end
end
