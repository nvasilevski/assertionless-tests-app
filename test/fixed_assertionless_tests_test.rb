require 'test_helper'

class FixedAssertionlessTestsTest < ActiveSupport::TestCase
  test "verifying a mock" do
    mock = Minitest::Mock.new
    mock.expect(
      :my_method,
      'return_value',
      ['arg_value']
    )
    mock.my_method('arg_value')
    assert_mock(mock)
  end

  test "ensure to reset tables state" do
    renamed = false
    DbConnectionHelper.rename_table(:dummy_table, :old_dummy_table)
    renamed = true

    assert_equal(1, DbConnectionHelper.execute("select 1 from old_dummy_table;"))
  ensure
    if renamed
      DbConnectionHelper.rename_table(:old_dummy_table, :dummy_table)
    end
  end

  test "my code doesn't raise" do
    assert_nothing_raised do
      MyCode.doesnt_raise
    end
  end

  test "do nothing by skipping test unless condition" do
    skip unless DbConnectionHelper.mysql_adapter?

    assert_equal("mysql2", DbConnectionHelper.adapter_name)
  end

  test "do nothing by not defining test unless condition" do
    assert_equal("mysql2", DbConnectionHelper.adapter_name)
  end if DbConnectionHelper.mysql_adapter?

  test "return value from instance" do
    my_object = MyObject.new
    my_object.execute_this_block_later_in_the_object_instance do
      my_value
    end

    my_object.my_value = "expected_value"

    assert_equal "expected_value", my_object.execute_stored_block
  end

  test "using custom message instead of flunk" do
    post = Post.first
    message = "Post should have non-empty body"
    assert_predicate post.body, :present?
  end

  test "all published posts should have a reviewer" do
    published_posts = Post.published.to_a

    if published_posts.empty?
      flunk("required pre-condition: no published posts to verify")
    end

    published_posts.each do |published_post|
      assert_predicate published_post.reviewer, :present?
    end
  end

  test "wrong minitest stubbing" do
    serializer_mock = Minitest::Mock.new
    my_elements = [:a, :b]
    my_collection = MyCollection.new(serializer: serializer_mock, elements: my_elements)
    expected_serialized_data = "[my_serialized_collection]"
    
    serializer_mock.expect(:encode, expected_serialized_data, [my_elements])
    assert_equal expected_serialized_data, my_collection.serialize
  end
end