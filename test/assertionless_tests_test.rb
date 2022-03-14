require 'test_helper'

class AssertionlessTestsTest < ActiveSupport::TestCase
  test "verifying a mock" do
    mock = Minitest::Mock.new
    mock.expect(:my_method, 'return_value', ['arg_value'])
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

    DbConnectionHelper.rename_table(:old_dummy_table, :dummy_table)
  end

  test "my code doesn't raise" do
    MyCode.doesnt_raise
  end

  test "do nothing unless condition" do
    if DbConnectionHelper.mysql_adapter?
      assert_equal("mysql2", DbConnectionHelper.adapter_name)
    end
  end

  test "return value from instance" do
    my_object = MyObject.new
    my_object.execute_this_block_later_in_the_object_instance do
      return my_value
    end

    my_object.my_value = "expected_value"

    assert_equal "expected_value", my_object.execute_stored_block
  end

  test "using flunk" do
    post = Post.first
    flunk("Post should have non-empty body") if post.body.empty?
  end

  test "all published posts should have a reviewer" do
    published_posts = Post.published.to_a

    published_posts.each do |published_post|
      assert_predicate published_post.reviewer, :present?
    end
  end

  test "wrong minitest stubbing" do
    serializer_mock = Minitest::Mock.new
    my_collection = MyCollection.new(serializer: serializer_mock)
    expected_serialized_data = "[my_serialized_collection]"
    
    serializer_mock.expect(:encode, expected_serialized_data) do
      assert_equal expected_serialized_data, my_collection.serialize
    end
  end
end