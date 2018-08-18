module Queries

  class IpQueries

    class << self
      def ip_list_query
      <<-SQL
        select distinct(p.author_ip), array_agg(a.login) from posts p
        inner join authors a on p.author_id = a.id 
        group by p.author_ip having count(login) > 1
      SQL
      end
    end
  end
end

