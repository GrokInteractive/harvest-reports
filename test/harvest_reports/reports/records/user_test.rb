require 'test_helper'

class HarvestReports::Reports::Records::UserTest < Minitest::Test
  def test_record_generation
    subject = HarvestReports::Reports::Records::User.new(user, billable_entries, nonbillable_entries, expected_hours)

    result = subject.to_h

    assert_equal('John Doe', result['Name'])
    assert_equal('0.74%', result['Rounded Billable Actualized'].to_s)
    assert_equal('0.74%', result['Billable Actualized'].to_s)
    assert_equal('1.14%', result['Actualized Time'].to_s)
    assert_equal(1, result['Rounded Billable Time'])
    assert_equal(1, result['Rounded Nonbillable Time'])
    assert_equal(2, result['Rounded All Time'])
    assert_equal(1, result['Billable Time'])
    assert_equal(1, result['Nonbillable Time'])
    assert_equal(2, result['All Time'])
  end

  private

  def user
    User.new(1, 'John', 'Doe')
  end

  def billable_entries
    [
      TimeEntry.new(1, 1, 1, 1, '2016-01-01')
    ]
  end

  def nonbillable_entries
    [
      TimeEntry.new(1, 1, 1, 1, '2016-01-01')
    ]
  end

  def expected_hours
    range = HarvestReports::Reports::Support::FormattedDateRange.new(Date.parse('2016-01-01'), Date.parse('2016-02-01'))
    HarvestReports::Reports::Support::ExpectedHours.new(range)
  end
end

