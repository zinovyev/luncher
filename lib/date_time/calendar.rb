module DateTime
  class Calendar
    def get_number_of_days(d = nil)
      d ||= now_date
      Date.new(d.year, d.month, -1).mday
    end

    private

    def now_date
      @now_date ||= Date.new
    end
  end
end
