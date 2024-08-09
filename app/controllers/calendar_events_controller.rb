class CalendarEventsController < LoggedController
  def index
    @bookings = Bookings::Daily.new(Current.account, date).call
  end

    private

      def date
        params[:date] || Date.current.to_s
      end
end
