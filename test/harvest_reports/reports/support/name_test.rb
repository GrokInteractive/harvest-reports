require 'test_helper'

class HarvestReports::Reports::Support::NameTest < Minitest::Test
  def test_to_s
    subject = HarvestReports::Reports::Support::Name.new('John')

    result = subject.to_s

    assert_equal('John', result)
  end

  def test_comparison
    subject = HarvestReports::Reports::Support::Name.new('john')

    result = subject <=> HarvestReports::Reports::Support::Name.new('Kevin')

    assert_equal(-1, result)
  end
end
