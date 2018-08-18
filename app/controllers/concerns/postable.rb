module Postable
  extend ActiveSupport::Concern

  included do

    def create
      author = get_valid_author params['login']
      post = validate_post( author, params)
      render json: post, status: :ok
    end

    def best_posts
      if params['rating'].present?
        top_posts = Queries::PostQueries.new(
          params['rating'],
          params.fetch('length', 10)
        ).top_posts
        render json: top_posts, status: :ok
      else
        render status: 422
      end
    end

    protected

    def validate_post(author,params = {})
      post = Post.new(
      title: params['title'],
      body: params['body'],
      author_ip: params[:author_ip],
      author: author
      )
      _validate_object PostValidator, post
    end

    def get_valid_author login
      author = Author.find_or_initialize_by(login: login)
      return author if author.persisted?
      _validate_object AuthorLoginValidator, author
    end

    def _validate_object(validator_kls, obj)
      validator = validator_kls.new(obj)
      if validator.valid?
        obj.save!
        obj
      else
        render status: 422, json: validator.errors.messages
      end
    end

  end
end