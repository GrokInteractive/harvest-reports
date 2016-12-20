require 'test_helper'

class HarvestReports::Reports::Records::ProjectTest < Minitest::Test
  def test_record_generation
    subject = HarvestReports::Reports::Records::Project.new(project, billable_entries, nonbillable_entries)

    result = subject.to_h

    assert_equal('Grok Interactive, LLC', result['Client Name'].to_s)
    assert_equal('Internal', result['Project Name'].to_s)
    assert_equal(1, result['Rounded Billable Time'])
    assert_equal(1, result['Rounded Nonbillable Time'])
    assert_equal(2, result['Rounded All Time'])
    assert_equal(1, result['Billable Time'])
    assert_equal(1, result['Nonbillable Time'])
    assert_equal(2, result['All Time'])
  end

  private

  def project
    Project.find(3419326)
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
end

