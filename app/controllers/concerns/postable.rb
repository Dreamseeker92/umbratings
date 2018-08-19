module Postable
  extend ActiveSupport::Concern

  included do

    def create
      author = get_valid_author params['login']
      if author.kind_of?(Author)
        post = validate_post( author, params)
        render json: post, :status => get_status_for_post(post)
      else
        render json: author, status: 422
      end
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

    def get_status_for_post post
      post.is_a?(Post) ? 'ok'.to_sym : 422.to_sym
    end

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
        validator.errors.messages
      end
    end

  end
end