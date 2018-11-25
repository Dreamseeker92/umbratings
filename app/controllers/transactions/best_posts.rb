class BestPosts
  include Dry::Transaction

  step :validate_length
  step :query_top_posts

  def validate_length(input)
    params = input
    params['length'] = params['length'].to_i
    length_validation = PostLengthSchema.(params)
    length_validation.success? ? Success(params) : Failure(length_validation.errors)
  end

  def query_top_posts(input)
    query = Queries::PostQueries.top_posts(input['length'])
    posts = ActiveRecord::Base.connection.exec_query(query)
    Success(posts)
  end
end