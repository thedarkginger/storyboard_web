class ShowsController < ApplicationController
  before_action :authenticate_user!

  def new
    redirect_to new_podcast_path and return if current_user.show.present?
    @show = current_user.build_show
  end

  def create
    @show = current_user.build_show(show_params)
    
    if @show.save
      flash[:success] = "Show created Successfully!!!"
      redirect_to new_podcast_path
    else
      flash.now[:error] = @show.errors.full_messages
      render 'new'
    end
  end

  private

  def show_params
    params.require(:show).permit(:name, :description, :image)
  end
end