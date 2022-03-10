class Post
  attr_accessor :body

  def self.first
    post = new
    post.body = "default body"
    post
  end

  def self.published
    []
  end
end