class BookingsController < ApplicationController
  after_action :authorize_booking
  before_action :set_booking, only: [:show, :edit, :update, :destroy, :approve, :decline]

  def show; end

  def new
    @wand = Wand.find(params[:wand_id])
    @booking = Booking.new
    @booking.wand = @wand
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.wand = Wand.find(params[:wand_id])

    if @booking.save
      render json: { status: 'ok' }
    else
      render :new
    end
  end

  def edit
    @wand = @booking.wand
  end

  def update
    if @booking.update(booking_params)
      render json: { status: 'ok' }
    else
      render :edit
    end
  end

  def destroy
    @booking.destroy

    redirect_to dashboard_path(:anchor => "v-pills-profile"), notice: 'Booking was successfully deleted.'
  end

  def approve
    @booking.update(status: 'approved')
    
    redirect_to dashboard_path(:anchor => "v-pills-lending"), notice: 'Request was successfully approved.'
  end

  def decline
    @booking.update(status: 'decline')

    redirect_to dashboard_path(:anchor => "v-pills-lending"), notice: 'Request was declined.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:check_out, :check_in)
  end

  def authorize_booking
    authorize @booking
  end
end
