class PodcastsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_show

  def new
    @podcast = @show.podcasts.new
  end

  def create
    @podcast = @show.podcasts.build(podcast_params)
    if @podcast.save
      original_filename = params[:podcast][:audio].original_filename
      temp_file = "#{Rails.root}/public/tmp/#{DateTime.now.strftime('%Q')}_#{original_filename}"

      file = params[:podcast][:audio].tempfile
      File.open(temp_file, "wb") do |f|
        f.write(File.open(file).read)
      end

      AudioUploadingWorker.perform_async({
        id: @podcast.id,
        original_filename: original_filename,
        temp_file: temp_file
      })

      flash[:success] = "Podcast created Successfully!!!"
      redirect_to @podcast
    else
      flash.now[:error] = @podcast.errors.full_messages
      render 'new'
    end
  end

  def index
    @podcasts = Podcast.all
    respond_to do |format|
      format.js
      format.html
      format.json { render json: @podcasts, status: :ok }
    end
  end

  def show
    @podcast = @show.podcasts.find_by_id(params[:id])
  end

  private

  def podcast_params
    params.require(:podcast).permit(:name, :description, :date, :paywall)
  end

  def check_show
    @show = current_user.show

    unless @show.present?
      flash[:error] = "Show must exists before continue."
      redirect_to new_show_path and return
    end
  end
end
