module Queries

  class PostQueries

    class << self
      def top_posts(length)
      <<~SQL
       select posts.title, posts.body from posts
       where posts.average_rating = (select p.average_rating from posts p 
       inner join ratings r on p.id = r.post_id group by p.average_rating
       having count(r.*) > 1 limit 1) limit #{length}
      SQL
      end
    end
  end
end

