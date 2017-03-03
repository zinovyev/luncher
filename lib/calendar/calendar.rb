require 'calendar/weekday'

module Calendar
  class Calendar
    attr_reader :date

    def initialize
      self.date = Date.today
    end

    def paginate(page = nil)
      if page.to_i
        page = normalize_page(page)    
        self.date = self.date >> page
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
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    end

    def table_days
      table = []
      days = list_days
      (1..weeks_in_month).each_with_index do |week_num|
        week = []
        month_days = list_days
        (1..7).each do |wday|
          if (1 == week_num && wday <= first_weekday && !days.empty?)
            week << nil
          else
            day = days.shift
            week << Weekday.new(date.year, date.month, day) if day
          end
        end 
        table << week
      end
      table
    end

    private

    def normalize_page(page)
      page = page > 0 ? page - 1 : page
    end

    def normalize_date(date)
      Date.new(date.year, date.month, 1)
    end

    def days_in_month
      Date.new(date.year, date.month, -1).mday
    end

    def weeks_in_month
      ((first_weekday + days_in_month) / 7.0).ceil
    end

    def first_weekday
      date.wday
    end
  end
end
