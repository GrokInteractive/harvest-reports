require 'test_helper'

class TimeEntrySummerTest < Minitest::Test
  def test_sum_rounded_entries
    subject = TimeEntrySummer.new

    result = subject.sum_rounded_entries(entries)

    assert_equal(1.25, result)
  end

  def test_sum_rounded_entries
    subject = TimeEntrySummer.new

    result = subject.sum_entries(entries)

    assert_equal(1.24, result)
  end

  def entries
    [
      TimeEntry.new(hours: 1.00),
      TimeEntry.new(hours: 0.2401)
    ]
  end
end
