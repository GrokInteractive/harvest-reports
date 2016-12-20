module HarvestReports
  desc 'Build a ranged report of Harvest Timesheets for every active project'
  long_desc <<-DESC
    Build a report for all the Harvest Time entries for all employees for the specified range.

    The format for the command is `harvest-report ranged-report yyyy-mm-dd yyyy-mm-dd`, where
    yyyy-mm-dd specify the start and end year, month, and day for the report, respectively.

    An example for a report between 1 January 2016 and 7 January 2016, `harvest-report ranged-report 2016-01-01 2016-01-07
  DESC

  arg 'yyyy-mm-dd'
  arg 'yyyy-mm-dd'

  command 'project-ranged-report' do |c|
    c.action do |global_options, options, arguments|
      c.switch :csv, default_value: false, desc: 'Print the results as a CSV'
      c.flag [:s, :sort], default_value: 'Name'

      date_range = FormattedDateRange.from_strings(arguments[0], arguments[1])
      sort = HarvestReports::Reports::Support::Sort.new(options[:sort])
      renderer = HarvestReports::Reports::Renderers.locate(options[:csv] ? 'csv' : 'table')

      HarvestReports::Reports::ProjectReport.new.report(date_range: date_range, sort: sort, renderer: renderer)
    end
  end
end
