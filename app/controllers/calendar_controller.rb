class CalendarController < LoggedController
  def index
    monthly_info = Bookings::Monthly.new(date)
    # query que agrupe los bookings por schedule cat y que sume los participants, agrupados por dia
    @weeks = monthly_info.weeks
    @selected_month = monthly_info.selected_month
  end

  private

    def date
      params[:date].presence || Date.current.strftime("%Y-%m")
    end
end
