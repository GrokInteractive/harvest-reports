module HarvestReports::Reports::Support
  class TimeEntrySummer
    def sum_rounded_entries(entries)
      entries.reduce(0) { |hours, entry| hours + entry.rounded_hours }.round(2)
    end

    def sum_entries(entries)
      entries.reduce(0) { |hours, entry| hours + entry.hours }.round(2)
    end
  end
end
