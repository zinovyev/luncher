require 'calendar/weekday'

module Calendar
  class Calendar
    attr_accessor :date, :organization

    def initialize(organization)
      self.date = Time.zone.today
      @organization = organization
    end

    def paginate(page = nil)
      if page.to_i
        page = normalize_page(page)
        self.date = date >> page
      end
      self
    end

    def date=(date)
      @date = normalize_date(date)
    end

    def list_days
      (1..days_in_month).to_a
    end

    def days_table_header
      %w(Mon Tue Wed Thu Fri Sat Sun)
    end

    # rubocop:disable Metrics/AbcSize
    def table_days
      table = []
      days = list_days
      prices = ordered_prices
      current_date = first_day_of_month
      (1..weeks_in_month).each_with_index do |week_num|
        week = []
        (1..7).each do |wday|
          if 1 == week_num && wday <= first_weekday && days.present?
            week << nil
          else
            day = days.shift
            day_prices = prices[current_date.to_s] || []
            week << Weekday.new(current_date, day, day_prices) if day
            current_date += 1
          end
        end
        table << week
      end
      table
    end
    # rubocop:enable Metrics/AbcSize

    def month_title
      date.strftime('%Y %b')
    end

    private

    def ordered_prices
      Price
        .order(:date)
        .where(
          date: first_day_of_month..last_day_of_month,
          organization: @organization
        )
        .reduce({}) do |acc, price|
          date = price.date.to_s
          acc[date] = [] unless acc[date]
          acc[date] << price
          acc
        end
    end

    def first_day_of_month(date = self.date)
      Date.new(date.year, date.month, 1)
    end

    def last_day_of_month
      Date.new(date.year, date.month, -1)
    end

    def normalize_page(page)
      page.positive? ? page - 1 : page
    end

    def normalize_date(date)
      first_day_of_month(date)
    end

    def days_in_month
      last_day_of_month.mday
    end

    def weeks_in_month
      ((first_weekday + days_in_month) / 7.0).ceil
    end

    def first_weekday
      date.wday
    end
  end
end
