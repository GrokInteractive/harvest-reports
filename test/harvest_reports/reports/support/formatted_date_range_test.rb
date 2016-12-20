require 'test_helper'

class HarvestReports::Reports::Support::FormattedDateRangeTest < Minitest::Test
  def test_start_date
    subject = HarvestReports::Reports::Support::FormattedDateRange.new(Date.new(2016,1,1), Date.new(2016,1,7))

    result = subject.start_date

    assert_equal('20160101', result)
  end

  def test_end_date
    subject = HarvestReports::Reports::Support::FormattedDateRange.new(Date.new(2016,1,1), Date.new(2016,1,7))

    result = subject.end_date

    assert_equal('20160107', result)
  end

  def test_from_strings_validation
    assert_raises ArgumentError do
      HarvestReports::Reports::Support::FormattedDateRange.from_strings('20x6-10-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-1x-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-13-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-13-1', '2017-01-01')
    end

    assert_raises ArgumentError do
      HarvestReports::Reports::Support::FormattedDateRange.from_strings(nil, nil)
    end
  end

  def test_from_strings
    subject = HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-01-01', '2017-01-01')

    result = subject.start_date

    assert_equal('20160101', result)
  end

  def test_month_from_string
    subject = HarvestReports::Reports::Support::FormattedDateRange.month_from_string('2016-01')

    result = subject.start_date

    assert_equal('20160101', result)

    result = subject.end_date

    assert_equal('20160131', result)
  end

  def test_month_resolves_for_decimal_months
    subject = HarvestReports::Reports::Support::FormattedDateRange.month_from_string('2016-09')

    result = subject.start_date

    assert_equal('20160901', result)
  end

  def test_to_date
    subject = HarvestReports::Reports::Support::FormattedDateRange.to_date

    result = subject.start_date

    assert_equal('20130101', result)

    result = subject.end_date

    assert_equal(Date.today.strftime('%Y%m%d'), result)
  end

  def test_in_range_on_start_date
    subject = HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-01-01', '2016-01-03')

    result = subject.in_range?(Date.new(2016, 01, 01))
    assert_equal(true, result)
  end

  def test_in_range_between_dates
    subject = HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-01-01', '2016-01-03')

    result = subject.in_range?(Date.new(2016, 01, 02))
    assert_equal(true, result)
  end

  def test_in_range_on_end_date
    subject = HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-01-01', '2016-01-03')

    result = subject.in_range?(Date.new(2016, 01, 03))
    assert_equal(true, result)
  end

  def test_in_range_failure
    subject = HarvestReports::Reports::Support::FormattedDateRange.from_strings('2016-01-01', '2016-01-03')

    result = subject.in_range?(Date.new(2016, 01, 04))
    assert_equal(false, result)
  end
end
