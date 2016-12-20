require 'test_helper'

class HarvestReports::Reports::Support::TimeEntrySummerTest < Minitest::Test
  def test_sum_rounded_entries
    subject = HarvestReports::Reports::Support::TimeEntrySummer.new

    result = subject.sum_rounded_entries(entries)

    assert_equal(1.25, result)
  end

  def test_sum_rounded_entries
    subject = HarvestReports::Reports::Support::TimeEntrySummer.new

    result = subject.sum_entries(entries)

    assert_equal(1.24, result)
  end

  def entries
    [
      TimeEntry.new(nil, 1.00, nil, nil, '2016-01-01'),
      TimeEntry.new(nil, 0.2401, nil, nil, '2016-01-01')
    ]
  end
end
