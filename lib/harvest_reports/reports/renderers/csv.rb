require 'csv'

module HarvestReports::Reports::Renderers
  class CSV
    def print(records)
      puts HarvestReports::Reports::Support::CSV.to_csv(records)
    end
  end
end

