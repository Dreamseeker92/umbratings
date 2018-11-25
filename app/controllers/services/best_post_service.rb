class BestPostService < SimpleDelegator

  def best_posts
    query = BestPosts.new.call(params)
    if query.success?
      render json:  query.value!, status: :ok
    else
      render status: :unprocessable_entity
    end
  end
end