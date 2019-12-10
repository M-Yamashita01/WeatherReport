class Api::MicropostsController < ApplicationController
  def index
    @micropost = Micropost.joins(:user).search(search_params).select('microposts.*, users.*')
  end

  def create
    @micropost = Micropost.new(micropost_params)
    current_time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
    @micropost.created_at = current_time
    @micropost.updated_at = current_time

    if @micropost.save
      render 'create', formats: 'json', handlers: 'jbuilder'
    else
      render json: @micropost.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    post = Micropost.find_by(id: params[:id])
    post.destroy
  end

  private

  def search_params
    params.permit(:user_id)
  end

  def micropost_params
    params.permit(:user_id, :content)
  end
end
