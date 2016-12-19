require 'pry'
require 'harvested'
require 'ruby-progressbar'
require 'table_print'

class ProjectReport
  def initialize(harvest_client: HarvestClient.create, summer: TimeEntrySummer.new)
    @harvest_client = harvest_client
    @harvest_time_entries = HarvestTimeEntries.new(harvest_client.credentials)
    @summer = summer
  end

  def report(users = HarvestUsers.new(@harvest_client).all, date_range: FormattedDateRange.new(Date.today))
    progress_bar = ProgressBar.create(title: 'Generating Report', total: users.count, format: '%t: |%B|%P%')
    billable_entries = []
    nonbillable_entries = []
    all_entries = []

    clients = @harvest_client.clients.all
    projects = @harvest_client.projects.all


    # Capture
    users.each do |user|
      billable_entries += @harvest_time_entries.billable_entries(user: user, date_range: date_range)
      nonbillable_entries += @harvest_time_entries.nonbillable_entries(user: user, date_range: date_range)
      all_entries += @harvest_time_entries.all_entries(user: user, date_range: date_range)

      progress_bar.increment
    end

    # Organize
    project_entries = Hash.new { |h, k| h[k] = { billable_entries: [], nonbillable_entries: [], all_entries: [] } }

    billable_entries.each do |entry|
      project_entries[entry.project_id]

      project_entries[entry.project_id][:billable_entries].push(entry)
    end

    nonbillable_entries.each do |entry|
      project_entries[entry.project_id]

      project_entries[entry.project_id][:nonbillable_entries].push(entry)
    end

    all_entries.each do |entry|
      project_entries[entry.project_id]

      project_entries[entry.project_id][:all_entries].push(entry)
    end

    find_by_id = -> (array, id) do
      array.reduce(nil) do |memo, hash|
        return hash if hash['id'] == id
      end
    end

    project_entries.map do |entry|
      project = find_by_id.call(projects, entry[0])
      client = find_by_id.call(clients, project['client_id'])

      {
        client_name: client['name'],
        project_name: project['name'],
        rounded_billable_time: summer.sum_rounded_entries(entry[1][:billable_entries]),
        rounded_nonbillable_time: summer.sum_rounded_entries(entry[1][:nonbillable_entries]),
        rounded_all_time: summer.sum_rounded_entries(entry[1][:all_entries]),
        billable_time: summer.sum_entries(entry[1][:billable_entries]),
        nonbillable_time: summer.sum_entries(entry[1][:nonbillable_entries]),
        all_time: summer.sum_rounded_entries(entry[1][:all_entries]),
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

  command 'project-report' do |c|
    c.action do |global_options, options, arguments|
      tp ProjectReport.new.report(date_range: FormattedDateRange.month_from_string(arguments[0]))
    end
  end
end
