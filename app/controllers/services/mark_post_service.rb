class MarkPostService < SimpleDelegator
  def create
   post_mark = CreateMark.new.call(params)
    if post_mark.success?
      render json: calc_new_avg(post_mark.value!), status: :ok
    else
      render status: :unprocessable_entity
    end
  end

private

  def calc_new_avg(data)
    post = Post.find(data['post_id'])
    mark = data['mark']['mark']
    avg = post.average_rating.presence || 0
    r_count = post.ratings_count
    new_average_rating =  if avg.zero?
                            mark
                          else
                            (avg * r_count + mark) / (r_count + 1)
                          end
    { new_average_rating: new_average_rating }
  end
end