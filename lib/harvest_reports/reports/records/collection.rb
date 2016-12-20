module HarvestReports::Reports::Records
  class Collection
    def initialize(records: [], expected_hours:, sort: HarvestReports::Reports::Support::Sort.new)
      @records = records
      @expected_hours = expected_hours
      @sort = sort
    end

    def render(renderer)
      puts "Expected Billable: #{expected_hours.billable_hours_for_range}"
      puts "Expected Total:    #{expected_hours.all_hours_for_range}"

      renderer.print records.sort { |lhs, rhs| lhs[sort.to_s] <=> rhs[sort.to_s] }
    end

    private

    attr_reader :records, :expected_hours, :sort
  end
end
