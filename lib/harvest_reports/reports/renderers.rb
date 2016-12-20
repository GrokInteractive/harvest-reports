module HarvestReports::Reports
  module Renderers
    def self.locate(string)
      {
        'csv' => CSV.new,
        'table' => TablePrint.new
      }.fetch(string)
    rescue KeyError
      raise ArgumentError, "You must specify either 'csv' or 'table' as a rendering strategy"
    end
  end
end
