class PostCreateService < SimpleDelegator

  def create
    post = CreatePost.new.call(params)
    if post.success?
      render json: post.value!, status: :ok
    else
      render status: :unprocessable_entity
    end
  end
end