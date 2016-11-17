require 'test_helper'

class HarvestRounderTest < Minitest::Test
  def test_zero_hours_stay_zero
    subject = HarvestRounder.new

    result = subject.round(0)

    assert_equal(0, result)
  end

  def test_one_hour_stay_one
    subject = HarvestRounder.new

    result = subject.round(1)

    assert_equal(1, result)
  end

  def test_rounding_up_to_nearest_quarter
    subject = HarvestRounder.new

    result = subject.round(1.01)

    assert_equal(1.25, result)
  end
end
