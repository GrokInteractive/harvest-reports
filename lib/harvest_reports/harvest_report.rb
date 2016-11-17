require 'harvested'
require 'ruby-progressbar'
require 'table_print'

class HarvestReport
  def initialize(harvest_client: HarvestClient.create, summer: TimeEntrySummer.new)
    @harvest_client = harvest_client
    @harvest_time_entries = HarvestTimeEntries.new(harvest_client.credentials)
    @summer = summer
  end

  def report(users = HarvestUsers.new(@harvest_client).all, date_range: FormattedDateRange.new(Date.today))
    progress_bar = ProgressBar.create(title: 'Generating Report', total: users.count, format: '%t: |%B|%P%')
    users.map do |user|
      billable_entries = @harvest_time_entries.billable_entries(user: user, date_range: date_range)
      nonbillable_entries = @harvest_time_entries.nonbillable_entries(user: user, date_range: date_range)
      all_entries = @harvest_time_entries.all_entries(user: user, date_range: date_range)

      progress_bar.increment

      {
        user: "#{user.first_name} #{user.last_name}",
        rounded_billable_time: summer.sum_rounded_entries(billable_entries),
        rounded_nonbillable_time: summer.sum_rounded_entries(nonbillable_entries),
        rounded_all_time: summer.sum_rounded_entries(all_entries),
        billable_time: summer.sum_entries(billable_entries),
        nonbillable_time: summer.sum_entries(nonbillable_entries),
        all_time: summer.sum_rounded_entries(all_entries),
      }
    end
  end

  private

  attr_reader :harvest_client, :harvest_time_entries, :summer
end


module HarvestReports

  desc 'Build a monthly report of Harvest Timesheets'
  long_desc <<-DESC
    Build a report for all the Harvest Time entries for all employees for the specified month.

    The format for the command is `harvest-report monthly-report yyyy-mm`, where
    yyyy-mm is the year and month for the report.

    An example for the month of January 2016, `harvest-report monthly-report 2016-01`
  DESC

  arg_name 'yyyy-mm'

  command 'monthly-report' do |c|
    c.action do |global_options, options, arguments|
      tp HarvestReport.new.report(date_range: FormattedDateRange.month_from_string(arguments[0]))
    end
  end

  desc 'Build a ranged report of Harvest Timesheets'
  long_desc <<-DESC
    Build a report for all the Harvest Time entries for all employees for the specified range.

    The format for the command is `harvest-report ranged-report yyyy-mm-dd yyyy-mm-dd`, where
    yyyy-mm-dd specify the start and end year, month, and day for the report, respectively.

    An example for a report between 1 January 2016 and 7 January 2016, `harvest-report ranged-report 2016-01-01 2016-01-07
  DESC

  arg_name 'yyyy-mm'
  arg_name 'yyyy-mm'

  command 'ranged-report' do |c|
    c.action do |global_options, options, arguments|
      tp HarvestReport.new.report(date_range: FormattedDateRange.from_strings(arguments[0], arguments[1]))
    end
  end
end
