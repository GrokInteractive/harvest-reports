require 'test_helper'

class TimeEntryTest < Minitest::Test
  def test_parsing
    result = TimeEntry.parse(object)

    assert_equal(527371269, result.id)
  end

  def test_rounded_hours
    subject  = TimeEntry.new(hours: 0.24)

    result = subject.rounded_hours

    assert_equal(0.25, result)
  end

  def object
    {
      "day_entry" => {
        "id" => 527371269,
        "notes" => "call with Randy",
        "spent_at" => "2016-10-20",
        "hours" => 0.25,
        "user_id" => 780419,
        "project_id" => 9846498,
        "task_id" => 2005389,
        "created_at" => "2016-10-20T18:09:44Z",
        "updated_at" => "2016-10-20T18:09:44Z",
        "adjustment_record" => false,
        "timer_started_at" => nil,
        "is_closed" => false,
        "is_billed" => true,
        "invoice_id" => 11088638
      }
    }
  end
end
