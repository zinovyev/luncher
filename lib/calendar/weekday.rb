module Calendar
  class Weekday
    attr_accessor :prices
    attr_reader :day, :date
    delegate :yead, :month, to: :date

    def initialize(date, day, prices = nil)
      @day = day
      @date = date
      @prices = prices
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
