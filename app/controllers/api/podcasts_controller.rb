class Api::PodcastsController< ApiController
	before_action :authenticate_user!
  before_action :check_show, only: [:create, :show, :update]
  before_action :find_podcast, only: [:show, :update]

  # GET /api/podcasts
  def index
    podcasts = Podcast.all
    render json: podcasts , status: :ok
  end

  # POST /api/podcasts
	def create
    podcast = current_user.show.podcasts.build(podcast_params)

    if podcast.save
      render json: podcast, status: :created
    else
      render json: podcast.errors.full_messages, status: :unprocessable_entity
    end
	end

  # GET /api/podcasts/:id
  def show
    render json: @podcast, status: :ok 
  end

  # PUT/PATCH /api/podcasts/:id
  def update
    if @podcast.update(podcast_params)
      render json: @podcast, status: :ok
    else
      render json: @podcast.errors.full_messages, status: :not_updated
    end
  end 

  private

  def podcast_params
    params.require(:podcast).permit(:name, :description, :date, :paywall, :audio)
  end

  def check_show
    show = current_user.show

    unless show.present?
      render json: { error: "Could not find Show." }, status: :not_found and return
    end
  end

  def find_podcast
    @podcast = current_user.show.podcasts.find_by_id(params[:id])

    unless @podcast.present?
      render json: { error: "Podcast not found."}, status: :not_found and return
    end
  end
end
