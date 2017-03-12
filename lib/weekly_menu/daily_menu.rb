module WeeklyMenu
  class DailyMenu 
    attr_accessor :date, :items
    attr_reader :first_courses, :main_courses, :drinks

    def initialize(date, items = [])
      @date = date
      self.items = items
    end

    def items=(items)
      @items = items
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
      if @last_items_count != @items.count
        courses = [[], [], []]
        @items.each do |item|
          courses[item.course] << item
        end
        @first_courses, @main_courses, @drinks = *courses
        @last_items_count = @items.count
      end
    end
  end
end
