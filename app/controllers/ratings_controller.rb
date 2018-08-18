class RatingsController < ApplicationController
  def create
    if params['mark'].present?
       MarkPostWorker.perform_async(params['post_id'], params['mark'].to_i)
       render json: Post.find(params[:post_id]).average_rating.to_f, status: :ok
    else
      render status: 422
    end
  end
end
