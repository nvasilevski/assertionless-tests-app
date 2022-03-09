class MyObject
  attr_accessor :my_value

  def execute_this_block_later_in_the_object_instance(&block)
    @block_to_execute = block
  end

  def execute_stored_block
    instance_exec(&@block_to_execute)
  end
end