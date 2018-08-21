class MarkPostWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(post_id, mark)
    post = Post.find(post_id)
    if mark.present? && post.present?
      Post.transaction do
        Rating.create!(mark: mark, post: post)
          post.update(
          average_rating: Queries::RatingAverageQueries.new(post_id).average_rating
        )
      end
    end
  end

end
