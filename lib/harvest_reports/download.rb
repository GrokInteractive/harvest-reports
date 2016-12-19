require 'pry'
require 'harvested'
require 'ruby-progressbar'
require 'table_print'

class Download
  def initialize(harvest_client: HarvestClient.create)
    @harvest_client = harvest_client
    @harvest_time_entries = HarvestTimeEntries.new(harvest_client.credentials)
  end

  def report(users = HarvestUsers.new(@harvest_client).all, date_range: FormattedDateRange.to_date)
    progress_bar = ProgressBar.create(title: 'Generating Report', total: users.count * 3, format: '%t: |%B|%P%')

    billable_entries = []
    nonbillable_entries = []
    all_entries = []
    clients = @harvest_client.clients.all
    projects = @harvest_client.projects.all

    users.map do |user|
      progress_bar.log "Downloading Billable Entries for     #{user.first_name} #{user.last_name}"
      billable_entries.push *@harvest_time_entries.billable_entries(user: user, date_range: date_range)
      progress_bar.increment

      progress_bar.log "Downloading Non-Billable Entries for #{user.first_name} #{user.last_name}"
      nonbillable_entries.push *@harvest_time_entries.nonbillable_entries(user: user, date_range: date_range)
      progress_bar.increment

      progress_bar.log "Downloading All Entries for          #{user.first_name} #{user.last_name}"
      all_entries.push *@harvest_time_entries.all_entries(user: user, date_range: date_range)
      progress_bar.increment
    end

    users.map! {|user| user.to_h }
    billable_entries.map! { |entry| entry.to_h }
    nonbillable_entries.map! { |entry| entry.to_h }
    all_entries.map! { |entry| entry.to_h }
    clients.map! { |client| client.to_h }
    projects.map! { |projects| projects.to_h }

    File.open("./download/billable_entries.json", "w+") do |file|
      file.write(billable_entries.to_json)
    end

    File.open("./download/nonbillable_entries.json", "w+") do |file|
      file.write(nonbillable_entries.to_json)
    end

    File.open("./download/all_entries.json", "w+") do |file|
      file.write(all_entries.to_json)
    end

    File.open("./download/users.json", "w+") do |file|
      file.write(users.to_json)
    end

    File.open("./download/clients.json", "w+") do |file|
      file.write(clients.to_json)
    end

    File.open("./download/projects.json", "w+") do |file|
      file.write(projects.to_json)
    end

    progress_bar.log "Download complete"
  end
end


module HarvestReports

  desc 'Download all necessary data'
  long_desc <<-DESC
    Build a report for all the Harvest Time entries for all employees for the specified month.

    The format for the command is `harvest-report monthly-report yyyy-mm`, where
    yyyy-mm is the year and month for the report.

    An example for the month of January 2016, `harvest-report monthly-report 2016-01`
  DESC

  arg_name 'yyyy-mm'

  command 'download' do |c|
    c.action do |global_options, options, arguments|
      Download.new.report(date_range: FormattedDateRange.to_date)
    end
  end
end
