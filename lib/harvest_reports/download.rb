require 'ruby-progressbar'

class Download
  def initialize(harvest_client: HarvestClient.create)
    @harvest_client = harvest_client
    @harvest_time_entries = HarvestTimeEntries.new(harvest_client.credentials)
  end

  def execute
    users = HarvestUsers.new(@harvest_client).all
    clients = @harvest_client.clients.all
    projects = @harvest_client.projects.all
    date_range = HarvestReports::Reports::Support::FormattedDateRange.to_date

    progress_bar = ProgressBar.create(title: 'Generating Report', total: users.count * 2, format: '%t: |%B|%P%')

    billable_entries = []
    nonbillable_entries = []

    users.map do |user|
      progress_bar.log "Downloading Billable Entries for     #{user.first_name} #{user.last_name}"
      billable_entries.push *@harvest_time_entries.billable_entries(user: user, date_range: date_range)
      progress_bar.increment

      progress_bar.log "Downloading Non-Billable Entries for #{user.first_name} #{user.last_name}"
      nonbillable_entries.push *@harvest_time_entries.nonbillable_entries(user: user, date_range: date_range)
      progress_bar.increment
    end

    {
      "./download/users.json" => users.map! {|user| user.to_h },
      "./download/billable_entries.json" => billable_entries.map! { |entry| entry.to_h },
      "./download/nonbillable_entries.json" => nonbillable_entries.map! { |entry| entry.to_h },
      "./download/clients.json" => clients.map! { |client| client.to_h },
      "./download/projects.json" => projects.map! { |projects| projects.to_h }
    }.each do |filename, array|
      File.open(filename, "w+") do |file|
        file.write(array.to_json)
      end
    end

    progress_bar.log "Download complete"
  end
end


module HarvestReports

  desc 'Download all Harvest data'

  command 'download' do |c|
    c.action do |global_options, options, arguments|
      Download.new.execute
    end
  end
end
