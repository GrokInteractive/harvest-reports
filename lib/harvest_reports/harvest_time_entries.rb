require 'harvested'

class HarvestTimeEntries < Harvest::API::Base
  def billable_entries(user:, date_range: FormattedDateRange.new)
    JSON.parse(request(:get, credentials, "/people/#{user.id}/entries", query: { from: date_range.start_date, to: date_range.end_date, billable: 'yes' }).body).map do |entry|
      TimeEntry.parse(entry)
    end
  end

  def nonbillable_entries(user:, date_range: FormattedDateRange.new)
    JSON.parse(request(:get, credentials, "/people/#{user.id}/entries", query: { from: date_range.start_date, to: date_range.end_date, billable: 'no' }).body).map do |entry|
      TimeEntry.parse(entry)
    end
  end

  def all_entries(user:, date_range: FormattedDateRange.new)
    JSON.parse(request(:get, credentials, "/people/#{user.id}/entries", query: { from: date_range.start_date, to: date_range.end_date }).body).map do |entry|
      TimeEntry.parse(entry)
    end
  end
end
