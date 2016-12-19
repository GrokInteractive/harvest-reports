require 'test_helper'

class FormattedDateRangeTest < Minitest::Test
  def test_start_date
    subject = FormattedDateRange.new(Date.new(2016,1,1), Date.new(2016,1,7))

    result = subject.start_date

    assert_equal('20160101', result)
  end

  def test_end_date
    subject = FormattedDateRange.new(Date.new(2016,1,1), Date.new(2016,1,7))

    result = subject.end_date

    assert_equal('20160107', result)
  end

  def test_from_strings_validation
    assert_raises ArgumentError do
      FormattedDateRange.from_strings('20x6-10-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      FormattedDateRange.from_strings('2016-1x-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      FormattedDateRange.from_strings('2016-13-01', '2017-01-01')
    end

    assert_raises ArgumentError do
      FormattedDateRange.from_strings('2016-13-1', '2017-01-01')
    end

    assert_raises ArgumentError do
      FormattedDateRange.from_strings(nil, nil)
    end
  end

  def test_from_strings
    subject = FormattedDateRange.from_strings('2016-01-01', '2017-01-01')

    result = subject.start_date

    assert_equal('20160101', result)
  end


  def test_month_from_string
    subject = FormattedDateRange.month_from_string('2016-01')

    result = subject.start_date

    assert_equal('20160101', result)

    result = subject.end_date

    assert_equal('20160131', result)
  end

  def test_to_date
    subject = FormattedDateRange.to_date

    result = subject.start_date

    assert_equal('20130101', result)

    result = subject.end_date

    assert_equal(Date.today.strftime('%Y%m%d'), result)
  end
end
