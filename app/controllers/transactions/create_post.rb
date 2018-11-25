require 'dry-transaction'

class CreatePost
  include Dry::Transaction

  step :validate_author
  step :find_or_create_author
  step :validate_post
  step :create_post

  def validate_author(input)
    author_validation = LoginSchema.(input)
    author_validation.success? ? Success(input) : Failure(author_validation.errors)
  end

  def find_or_create_author(input)
    author = Author.find_or_create_by!(login: input['login'])
    Success(input.merge('author_id' => author.id))
  end

  def validate_post(input)
    post_validation = PostSchema.(input)
    post_validation.success? ? Success(post_validation) : Failure(post_validation.errors)
  end

  def create_post(input)
    params = input.output
    post = Post.new(
      title: params['title'],
      body: params['body'],
      author_ip: params['author_ip'],
      author_id: params['author_id']
    )
    if post.save!
      Success(post)
    else
      Failure(post.errors.messages)
    end
  end
end