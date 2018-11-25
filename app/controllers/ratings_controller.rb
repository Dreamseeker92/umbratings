class RatingsController < ApplicationController
  def create
    MarkPostService.new(self).create
  end
end
