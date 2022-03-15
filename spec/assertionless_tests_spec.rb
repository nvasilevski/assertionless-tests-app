require 'rails_helper'

describe "assertionless tests" do
  it "does nothing unless condition" do
    if DbConnectionHelper.mysql_adapter?
      expect(DbConnectionHelper.adapter_name).to eq("mysql2")
    end
  end

  it "verifies all published posts should have a reviewer" do
    published_posts = Post.published.to_a

    published_posts.each do |published_post|
      expect(published_post.reviewer).to be_truthy
    end
  end
end