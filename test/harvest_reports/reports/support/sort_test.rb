require 'test_helper'

class HarvestReports::Reports::Support::SortTest < Minitest::Test
  def test_all_valid_options_for_initialization

     [
      'Name',
      'Client Name',
      'Project Name',
      'Rounded Billable Actualized',
      'Billable Actualized',
      'Actualized Time',
      'Rounded Billable Time',
      'Rounded Nonbillable Time',
      'Rounded All Time',
      'Billable Time',
      'Nonbillable Time',
      'All Time',
    ].each do |option|
      subject = HarvestReports::Reports::Support::Sort.new(option)

      result = subject.to_s

      assert_equal(option, result)
    end
  end

  def test_invalid_option_raises_error_upon_initialization
    assert_raises(ArgumentError) do
      HarvestReports::Reports::Support::Sort.new('Invalid Option')
    end
  end
end
