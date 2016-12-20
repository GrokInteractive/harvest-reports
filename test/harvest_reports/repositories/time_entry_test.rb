require 'test_helper'

class TimeEntryTest < Minitest::Test
  def test_from_json
    subject = TimeEntry.from_json({'id' => 42, 'hours' => 11.2, 'user_id' => 22, 'project_id' => 33, 'spent_at' => '2016-01-01'})

    result = subject.id
    assert_equal(42, result)

    result = subject.user_id
    assert_equal(22, result)

    result = subject.project_id
    assert_equal(33, result)

    result = subject.hours
    assert_equal(11.2, result)

    result = subject.date
    assert_equal(Date.parse('2016-01-01'), result)
  end

  def test_to_h
    subject = TimeEntry.from_json({'id' => 42, 'hours' => 11.2, 'user_id' => 22, 'project_id' => 33, 'spent_at' => '2016-01-01'})

    result = subject.to_h
    expected_result = {
      id: 42,
      hours: 11.2,
      user_id: 22,
      project_id: 33,
      date: Date.parse('2016-01-01')
    }
    assert_equal(expected_result, result)
  end


  def test_parsing
    result = TimeEntry.parse(object)

    assert_equal(527371269, result.id)
  end

  def test_rounded_hours
    subject = TimeEntry.new(nil, 0.24, nil, nil, '2016-01-01')

    result = subject.rounded_hours

    assert_equal(0.25, result)
  end

  def test_project
    subject = TimeEntry.new(nil, 0.24, nil, 3419326, '2016-01-01')

    result = subject.project

    assert_equal('Internal', result.name)
  end

  def test_user
    subject = TimeEntry.new(nil, 0.24, 1321659, nil, '2016-01-01')

    result = subject.user

    assert_equal('Alexander', result.first_name)
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
