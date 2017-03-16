module Calendar
  class Weekday
    attr_accessor :prices
    attr_reader :year, :month, :day, :date

    def initialize(date, day, prices = nil)
      @day = day
      @date = date
      @prices = prices
    end

    def year
      date.year
    end

    def month
      date.month
    end

    def prices
      @prices ||= fetch
    end

    private

    def fetch
      Price.where(
        'date = :date',
        date: "#{year}-#{month}-#{day}"
      )
    end
  end
end
