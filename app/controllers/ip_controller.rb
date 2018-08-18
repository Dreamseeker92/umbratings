class IpController < ApplicationController
  def ip_list
    ip_list = Post.find_by_sql Queries::IpQueries.ip_list_query
    render json: ip_list, status: :ok
  end
end