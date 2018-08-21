module Markable
  extend ActiveSupport::Concern

  included do
    def create
      mark = params['mark'].to_i
      if mark.present? && validate_mark(mark)
        post = Post.find(params[:post_id])
        MarkPostWorker.perform_async(params['post_id'], mark)
        render json: calc_new_avg( post, mark), status: :ok
      else
        render status: 422
      end
    end

    protected

    def validate_mark mark
      RatingMarkValidator.new(Rating.new(mark: mark)).valid?
    end

    def calc_new_avg post, mark
      avg = post.average_rating.presence || 0
      r_count = post.ratings_count
      { new_average_rating: (avg * r_count + mark) / (r_count + 1) }
    end
  end
end