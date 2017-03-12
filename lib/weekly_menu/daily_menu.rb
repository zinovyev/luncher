module WeeklyMenu
  class DailyMenu 
    attr_accessor :date, :prices
    attr_reader :first_courses, :main_courses, :drinks

    def initialize(date, prices = [])
      @date = date
      self.prices = prices
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
  end
end
