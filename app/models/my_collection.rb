class MyCollection
  def initialize(serializer:, elements: [])
    @serializer = serializer
    @elements = elements
  end

  def serialize
    @serializer.encode(@elements)
  end
end