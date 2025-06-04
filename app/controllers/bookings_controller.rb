class BookingsController < ApplicationController
  before_action :find_booking, only: %i[edit update destroy]
  before_action :schedule_categories, only: %i[new create edit update]
  before_action :find_resources, only: %i[new create edit update]
  before_action :find_date, only: %i[index]
  before_action :find_bookings, only: %i[index]

  def index
  end

  def new
    @booking = Current.user.bookings.new start_on: booking_date, schedule_category_id: schedule_categories.first[0]
    @booking_custom_attributes = @booking.booking_custom_attributes.build
    @current_info = Bookings::CurrentInfo.new(@booking.start_on, @booking.schedule_category_id, Current.account).call
    available_resources
    custom_attributes
  end

  def create
    @booking =  Current.user.bookings.create booking_params
    if @booking.persisted?
      Bookings::BookingCustomAttributes.new(@booking, params[:custom_attribute_ids], Current.account).create
      redirect_to bookings_path, notice: t("booking.created")
    else
      available_resources
      custom_attributes
       @current_info = Bookings::CurrentInfo.new(@booking.start_on, @booking.schedule_category_id, Current.account).call
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @current_info = Bookings::CurrentInfo.new(@booking.start_on, @booking.schedule_category_id, Current.account).call
    available_resources
    custom_attributes
  end

  def update
    if @booking.update(booking_params)
      Bookings::BookingCustomAttributes.new(@booking, params[:custom_attribute_ids], Current.account).update
      redirect_to bookings_path, notice: t("bookings.updated")
    else
      available_resources
      custom_attributes
      @current_info = Bookings::CurrentInfo.new(@booking.start_on, @booking.schedule_category_id, Current.account).call
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy

    redirect_to bookings_path, notice: t("booking.deleted")
  end

  def check
    available_resources
    custom_attributes
    @current_info = Bookings::CurrentInfo.new(params[:start_on], params[:booking][:schedule_category_id], Current.account).call
  end

  private

    def booking_params
      params.require(:booking).permit(:start_on, :schedule_category_id, :participants,
         resource_bookings_attributes: %i[resource_id])
    end

    def find_booking
      @booking = if Current.user.admin?
        Current.account.bookings.find params[:id]
      else
        Current.user.bookings.find params[:id]
      end
    end

    def available_resources
      @available_resources, @errors = Bookings::AvailableResources.new(Current.user.id, start_on, schedule_category_id).call
    end

    def custom_attributes
      @custom_attributes = Bookings::CustomAttributes.new(Current.user, start_on, schedule_category_id).call
    end

    def start_on
      return @booking.start_on if params[:booking].blank? || params[:booking][:start_on].blank?

      params[:booking][:start_on]
    end

    def schedule_category_id
      @booking&.schedule_category_id || params.dig(:booking, :schedule_category_id)
    end

    def schedule_categories
      @schedule_categories ||= Current.account.schedule_categories.pluck(:id, :name)
    end

    def find_resources
      @resources = Current.account.resources
        .includes(:resource_bookings).order(max_capacity: :desc)
    end

    def booking_date
      return Date.current if params[:start_on].blank?

      Date.parse params[:start_on]
    rescue
      Date.current
    end

    def find_date
      @start_date = booking_date.beginning_of_month
      @end_date = booking_date.end_of_month
    end

    def find_bookings
      user_id = Current.account.users.find_by(id: params[:user_id])&.id
      resource_id = Current.account.resources.find_by(id: params[:resource_id])&.id

      @bookings = if user_id.present?
        Current.account.bookings.where(start_on: @start_date..@end_date, user_id: params[:user_id]).order(:start_on, :schedule_category_id)
      elsif resource_id.present?
        Current.account.bookings.joins(:resources).where(start_on: @start_date..@end_date, resources: { id: resource_id }).order(:start_on, :schedule_category_id)
      else
        Current.account.bookings.where(start_on: @start_date..@end_date).order(:start_on, :schedule_category_id)
      end
    end
end
