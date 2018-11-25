class MarkPostWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(post_id, mark)
    Post.transaction do
      post = Post.find(post_id)
      post.lock!
      Rating.create!(mark: mark, post: post)
      post.update!(
        average_rating: Queries::RatingAverageQueries.average_rating(post_id)
      )
    end
  end

end
