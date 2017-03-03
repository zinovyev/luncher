module Calendar
  class Weekday
    attr_reader :year, :month, :day

    def initialize(year, month, day)
      @year = year
      @month = month
      @day = day
    end

    def date
      Date.new(@year, @month, @day)
    end

    def prices
      @prices ||= Price.where(
        'date = :date',
        date: "#{year}-#{month}-#{day}"
      )
    end
  end
end
