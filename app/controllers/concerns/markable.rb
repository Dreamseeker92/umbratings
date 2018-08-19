module Markable
  extend ActiveSupport::Concern

  included do
    def create
      if params['mark'].present?
        jid = MarkPostWorker.perform_async(params['post_id'], params['mark'].to_i)
        until check_if_complete(jid) == :complete
          sleep 0.1
        end
        render json: { average_rating: Post.find(params[:post_id]).average_rating},
               status: :ok
      else
        render status: 422
      end
    end

    protected

    def check_if_complete jid
      Sidekiq::Status::status jid
    end
  end
end