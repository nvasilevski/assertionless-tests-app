require 'test_helper'

class FixedAssertionlessTestsTest < ActiveSupport::TestCase
  test "verifying a mock" do
    mock = Minitest::Mock.new.expect(:my_method, 'return_value', ['arg_value'])
    mock.my_method('arg_value')
    assert_mock(mock)
  end
end