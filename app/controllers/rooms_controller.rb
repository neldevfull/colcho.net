class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_users_room, only: [:edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :edit, :create,
    :update, :destroy]

  # GET /rooms
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  def create
    # It creates the room directly in the user session
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: t('flahs.notice.room.created')
    else
      render :new
    end
  end

  # PATCH/PUT /rooms/1
  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flahs.notice.room_updated')
    else
      render :edit
    end
  end

  # DELETE /rooms/1
  def destroy
    @room.destroy
    redirect_to rooms_url 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:title, :location, :description)
    end

    # Find all the rooms of the user in session 
    def set_users_room
      @room = current_user.rooms.find(params[:id])
    end
end
