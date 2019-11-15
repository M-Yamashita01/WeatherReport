class Api::MicropostsController < ApplicationController
  def index
    @micropost = Micropost.search(search_params).select('microposts.*')
  end

  def create
    @micropost = Micropost.new(micropost_params)
    current_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    @micropost.created_at = current_time
    @micropost.updated_at = current_time
    puts 'create test !!!!'
    puts @micropost
    puts @micropost.user_id
    puts @micropost.created_at

    if @micropost.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render json: @micropost.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def search_params
    params.permit(:user_id)
  end

  def micropost_params
    params.permit(:user_id, :content)
  end
end
