module Bookings
  class Monthly
    def initialize(date)
      @date = date
    end

    def selected_month
      start_of_month
    end

    def weeks
      (first_day..last_day).to_a.in_groups_of(7)
    end

    private

      attr_reader :date

      def first_day
        start_of_month.beginning_of_week
      end

      def last_day
        start_of_month.end_of_month.end_of_week
      end

      def start_of_month
        @start_of_month = Date.parse("#{date}-1")
      end
  end
end
