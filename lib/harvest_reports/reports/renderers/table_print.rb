require 'table_print'

module HarvestReports::Reports::Renderers
  class TablePrint
    def print(records)
      tp records
    end
  end
end

