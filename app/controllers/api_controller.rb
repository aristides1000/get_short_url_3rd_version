class ApiController < ApplicationController
  def getlinks
    @urls =  Url.all.order('created_at DESC').limit(10)
    render json:@urls, include: ['clicks']
  end
end
