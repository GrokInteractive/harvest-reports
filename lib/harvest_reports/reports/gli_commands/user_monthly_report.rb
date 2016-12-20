module HarvestReports
  desc 'Build a monthly report of Harvest Timesheets for every active user'
  long_desc <<-DESC
    Build a report for all the Harvest Time entries for all employees for the specified month.

    The format for the command is `harvest-report monthly-report yyyy-mm`, where
    yyyy-mm is the year and month for the report.

    An example for the month of January 2016, `harvest-report monthly-report 2016-01`
  DESC

  arg 'yyyy-mm'

  command 'user-monthly-report' do |c|
    c.switch :csv, default_value: false, desc: 'Print the results as a CSV'
    c.flag [:s, :sort], default_value: 'Name'

    c.action do |global_options, options, arguments|
      date_range = HarvestReports::Reports::Support::FormattedDateRange.month_from_string(arguments[0])
      sort = HarvestReports::Reports::Support::Sort.new(options[:sort])
      renderer = HarvestReports::Reports::Renderers.locate(options[:csv] ? 'csv' : 'table')

      HarvestReports::Reports::UserReport.new.report(date_range: date_range, sort: sort, renderer: renderer)
    end
  end
end
