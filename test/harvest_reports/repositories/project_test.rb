require 'test_helper'

class ProjectTest < Minitest::Test
  def test_from_json
    subject = Project.from_json({'id' => 42, 'client_id' => 11, 'name' => 'Some Name'})

    result = subject.id
    assert_equal(42, result)

    result = subject.client_id
    assert_equal(11, result)

    result = subject.name
    assert_equal('Some Name', result)
  end

  def test_find
    subject = Project.find(3419326)

    result = subject.name

    assert_equal('Internal', result)
  end

  def test_client
    subject = Project.find(3419326)

    result = subject.client

    assert_equal(1603844, result.id)
  end
end
