class PostsController < ApplicationController

  def create
    PostCreateService.new(self).create
  end

  def best_posts
    BestPostService.new(self).best_posts
  end
end
