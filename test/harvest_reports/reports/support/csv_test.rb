require 'test_helper'

class HarvestReports::Reports::Support::CSVTest < Minitest::Test
  def test_to_csv_on_an_array_of_hashes
    array = [
      {a: 1, b: 2},
      {a: 2, b: 3}
    ]

    result = HarvestReports::Reports::Support::CSV.to_csv(array)

    assert_equal("a,b\n1,2\n2,3\n", result)
  end
end
