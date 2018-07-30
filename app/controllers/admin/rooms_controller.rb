class Admin::RoomsController < ApplicationController
  before_action :require_admin_log_in
  before_action :set_room, only: %i[show edit update destroy]

  def index
  end

  def datatable
    render json: RoomDatatable.new(view_context)
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to admin_room_path(@room)
    else
      render :new
    end
  end

  def update
    if @room.update(room_params)
      redirect_to admin_room_path(@room)
    else
      render :edit
    end
  end

  def destroy
    @room.destroy
    redirect_to admin_rooms_path
  end

  private
  
  def room_params
    params.require(:room).permit(:name)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
