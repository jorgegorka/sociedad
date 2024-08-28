class BookingsController < LoggedController
  before_action :find_booking, only: %i[edit update destroy]
  before_action :find_schedule_categories, only: %i[new create edit update]
  before_action :find_resources, only: %i[new create edit update]
  before_action :find_date, only: %i[index]

  def index
    @bookings = Current.user.bookings.where("strftime('%Y-%m', start_on) = ?", @date).order(:start_on, :schedule_category_id)
  end

  def new
    @booking = Current.user.bookings.new start_on: booking_date
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
    @available_resources, @errors = Bookings::AvailableResources.new(Current.user.id, params[:start_on], params[:schedule_category_id]).call
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

    def booking_date
      return Date.current if params[:date].blank?

      Date.parse params[:date]
    rescue
      Date.current
    end

    def find_date
      date_today = Date.today.strftime("%Y-%m-%d")
      @date = params[:date].present? ? params[:date] : Date.parse(date_today).strftime("%Y-%m")
      @month_name = I18n.l(Time.now.beginning_of_year + @date.slice(5..10).to_i - 1, format: "%B")
    end
end
