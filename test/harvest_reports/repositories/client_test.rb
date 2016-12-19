require 'test_helper'

class ClientTest < Minitest::Test
  def test_from_json
    subject = Client.from_json({'id' => 42, 'name' => 'Some Name'})

    result = subject.id
    assert_equal(42, result)

    result = subject.name
    assert_equal('Some Name', result)
  end

  def test_find
    subject = Client.find(2067812)

    result = subject.name

    assert_equal('44Doors', result)
  end
end
