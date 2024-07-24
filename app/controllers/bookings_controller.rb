class BookingsController < ApplicationController
  before_action :find_booking, only: %i[edit update destroy]

  def index
    @bookings = Current.user.bookings
  end

  def new
    @booking = Current.user.bookings.new
  end

  def create
    @booking = Current.user.bookings.create booking_params

    if @booking.save
      notice = t('booking.created')
      redirect_to bookings_path, notice:
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      notice = t('bookings.updated')
      redirect_to bookings_path, notice:
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy

    notice = t('booking.deleted')

    redirect_to bookings_path, notice:
  end

  private

  def booking_params
    params.require(:booking).permit(:start_on, :schedule_category_id)
  end

  def find_booking
    @booking = Current.user.bookings.find params[:id]
  end
end
