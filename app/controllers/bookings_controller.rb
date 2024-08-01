class BookingsController < LoggedController
  before_action :find_booking, only: %i[edit update destroy]
  before_action :find_schedule_categories, only: %i[new create edit update]
  before_action :find_resources, only: %i[new create edit update]

  def index
    date_today = Date.today.strftime("%Y-%m-%d")
    @month_number = params[:month].present? ? params[:month].to_i : Date.parse(date_today).strftime("%m")

    @bookings = Current.user.bookings.where("strftime('%m', start_on) = ?", @month_number).order(:start_on, :schedule_category_id)
  end

  def new
    @booking = Current.user.bookings.new(start_on: Date.current)
  end

  def create
    if  Bookings::Creator.new(Current.user.id, params).call
      redirect_to bookings_path, notice: t("booking.created")
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
      redirect_to bookings_path, notice: t("bookings.updated")
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy

    redirect_to bookings_path, notice: t("booking.deleted")
  end

  def check
    available_resources
  end

  private

    def booking_params
      params.require(:booking).permit(:start_on, :schedule_category_id)
    end

    def find_booking
      @booking = Current.user.bookings.find params[:id]
    end

    def find_schedule_categories
      @schedule_categories = Current.account.schedule_categories.pluck(:id, :name)
    end

    def find_resources
      @resources = Current.account.resources
        .includes(:resource_bookings).order(max_capacity: :desc)
    end

    def available_resources
      @available_resources = Bookings::AvailableResources.new(Current.user.id, params[:start_on], params[:schedule_category_id]).call
    end
end
