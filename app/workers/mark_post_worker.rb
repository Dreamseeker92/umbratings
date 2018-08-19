class MarkPostWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(post_id, mark)
    validated_mark = validate_mark mark
    post = Post.find(post_id)
    if validated_mark.present? && post.present?
      validated_mark.post_id = post_id
      Post.transaction do
        validated_mark.save
          post.update(
          average_rating: Queries::RatingAverageQueries.new(post_id).average_rating
        )
      end
    end
  end

  private

  def validate_mark mark
    r = Rating.new(mark: mark)
    RatingMarkValidator.new(r).valid? ? r : nil
  end

end
