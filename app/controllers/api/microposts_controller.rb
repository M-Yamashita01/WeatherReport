class Api::MicropostsController < ApplicationController
  def index
    @micropost = Micropost.search(search_params).select('microposts.*')
  end

  def search_params
    params.permit(:user_id)
  end
end
