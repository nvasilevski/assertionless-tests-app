require 'test_helper'

class AssertionlessTestsTest < ActiveSupport::TestCase
  test "verifying a mock" do
    mock = Minitest::Mock.new.expect(:my_method, 'return_value', ['arg_value'])
    mock.my_method('arg_value')
    mock.verify
  end

  test "ensure to reset tables state" do
    renamed = false
    DbConnectionHelper.rename_table(:dummy_table, :old_dummy_table)
    renamed = true

    assert_equal(1, DbConnectionHelper.execute("select 1 from old_dummy_table;"))
  ensure
    return unless renamed

    ConnectionHelper.rename_table(:old_dummy_table, :dummy_table)
  end

  test "my code doesn't raise" do
    MyCode.doesnt_raise
  end
end