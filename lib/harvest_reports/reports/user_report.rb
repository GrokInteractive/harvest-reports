module HarvestReports::Reports
  class UserReport
    def report(date_range: FormattedDateRange.new(Date.today), sort:, renderer:)
      billable_entries = TimeEntry.billable_entries.select { |entry| date_range.in_range?(entry.date) }.group_by { |entry| entry.user_id }
      nonbillable_entries = TimeEntry.nonbillable_entries.select { |entry| date_range.in_range?(entry.date) }.group_by { |entry| entry.user_id }

      users = users_from(billable_entries, nonbillable_entries)

      expected_hours = ExpectedHours.new(date_range)

      users.map! do |user|
        HarvestReports::Reports::Records::User.new(user, billable_entries[user.id], nonbillable_entries[user.id], expected_hours).to_h
      end

      HarvestReports::Reports::Records::Collection.new(records: users, expected_hours: expected_hours, sort: sort).render(renderer)
    end

    def users_from(billable_entries, nonbillable_entries)
      (billable_entries.keys + nonbillable_entries.keys).uniq { |id| id }.map { |id| User.find(id) }
    end
  end
end
