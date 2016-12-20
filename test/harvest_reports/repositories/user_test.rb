require 'test_helper'

class UserTest < Minitest::Test
  def test_from_json
    subject = User.from_json({'id' => 42, 'first_name' => 'John', 'last_name' => 'Doe'})

    result = subject.id
    assert_equal(42, result)

    result = subject.first_name
    assert_equal('John', result)

    result = subject.last_name
    assert_equal('Doe', result)
  end

  def test_find
    subject = User.find(1321659)

    result = subject.first_name

    assert_equal('Alexander', result)
  end

  def test_equal
    subject = User.find(1321659)

    result = subject == User.find(1321659)

    assert_equal(true, result)
  end

  def test_not_equal
    subject = User.find(1321659)

    result = subject == User.from_json({})

    assert_equal(false, result)
  end
end
