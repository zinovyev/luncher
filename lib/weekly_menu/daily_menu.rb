module WeeklyMenu
  class DailyMenu
    attr_accessor :name, :date, :prices
    attr_reader :first_courses, :main_courses, :drinks

    def initialize(name, date, prices = [])
      @name = name
      @date = date
      self.prices = prices
    end

    def sql_date
      date.strftime('%Y-%m-%d')
    end

    def first_courses
      sort_courses
      @first_courses
    end

    def main_courses
      sort_courses
      @main_courses
    end

    def drinks
      sort_courses
      @drinks
    end

    private

    # rubocop:disable Style/GuardClause
    def sort_courses
      if @last_prices_count != @prices.count
        courses = [[], [], []]
        @prices.each do |price|
          courses[price.item.course] << price
        end
        @first_courses, @main_courses, @drinks = *courses
        @last_prices_count = @prices.count
      end
    end
    # rubocop:enable Style/GuardClause
  end
end
