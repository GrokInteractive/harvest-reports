require 'test_helper'

class HarvestReports::Reports::Support::PercentTest < Minitest::Test
  def test_to_s
    subject = HarvestReports::Reports::Support::Percent.new(0.1)

    result = subject.to_s

    assert_equal('10.00%', result)
  end

  def test_comparison
    subject = HarvestReports::Reports::Support::Percent.new(0.1)

    result = subject <=> HarvestReports::Reports::Support::Percent.new(0.2)

    assert_equal(-1, result)
  end
end
