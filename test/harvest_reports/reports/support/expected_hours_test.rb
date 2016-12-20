require 'test_helper'

class HarvestReports::Reports::Support::ExpectedHoursTest < Minitest::Test
  def test_all_hours_for_range
    date_range = FormattedDateRange.month_from_string('2016-08')
    subject = HarvestReports::Reports::Support::ExpectedHours.new(date_range)

    result = subject.all_hours_for_range

    assert_equal(184, result)
  end

  def test_all_hours_for_range_with_a_holiday
    date_range = FormattedDateRange.month_from_string('2016-09')
    subject = HarvestReports::Reports::Support::ExpectedHours.new(date_range)

    result = subject.all_hours_for_range

    assert_equal(168, result)
  end

  def test_billable_hours_for_range
    date_range = FormattedDateRange.month_from_string('2016-08')
    subject = HarvestReports::Reports::Support::ExpectedHours.new(date_range)

    result = subject.billable_hours_for_range

    assert_equal(152, result)
  end

  def test_billable_hours_for_range_during_holidays
    date_range = FormattedDateRange.month_from_string('2016-12')
    subject = HarvestReports::Reports::Support::ExpectedHours.new(date_range)

    result = subject.billable_hours_for_range

    assert_equal(104, result)
  end

  def test_validate_range
    assert_raises(ArgumentError) do
      HarvestReports::Reports::Support::ExpectedHours.new(nil)
    end
  end
end
