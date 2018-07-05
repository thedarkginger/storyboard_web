class Api::ShowsController < ApiController
	before_action :authenticate_user!
  before_action :find_show, only: [:show, :update]

  # POST /api/shows
	def create  
		render json: { message: "You have already created your show." }, status: :unprocessable_entity and return if current_user.show.present?

    show =  current_user.build_show(show_params)
    if show.save
       render json: show, status: :created
    else
       render json: show.errors.full_messages, status: :unprocessable_entity
    end	     
	end

  # GET /api/shows/:id
	def show
    render json: @show, status: :ok
	end

  # PUT/PATCH /api/shows/:id
	def update
    if @show.update(show_params)
      render json: @show, status: :ok
    else
      render json: @show.errors.full_messages, status: :not_updated
    end
	end	

	private

	def show_params
	  params.require(:show).permit(:name, :description, :image)
	end

  def find_show
    @show = current_user.show

    if @show.nil?
      render json: { error: "Could not find Show."}, status: :not_found and return
    elsif @show.try(:id) != params[:id].to_i
      render json: { error: "User not authorized to access this Show."}, status: :unprocessable_entity and return
    end
  end
end
