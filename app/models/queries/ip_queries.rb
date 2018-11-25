module Queries

  class IpQueries

    class << self
      def ip_list_query
      <<-SQL
        select p.author_ip, array_agg(distinct a.login) from posts p
        inner join authors a on p.author_id = a.id 
        group by p.author_ip having count(distinct login) > 1
      SQL
      end
    end
  end
end

