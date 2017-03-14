require 'date'

module WeeklyMenu
  class WeeklyMenu
    attr_accessor :prices
    attr_reader :days

    def initialize
      @days = initialize_week_days
    end

    def [](name)
      @days[normalize_day_name(name)]
    end

    def []=(name, menu)
      name = normalize_day_name(name)
      @days[name] = menu if @days.key? name
    end

    def prices=(prices)
      @prices = prices
      sort_prices
    end

    def longest_price_stack
      @days.values.reduce(0) do |acc, day|
        acc = day.prices.count if acc < day.prices.count
        acc
      end
    end

    def price_rows
      rows = []
      (0..longest_price_stack).each do |i|
        row = []
        days.each do |_name, day|
          row << day.prices[i]
        end
        yield row if block_given?
        rows << row
      end
      rows
    end

    # rubocop:disable Style/MethodMissing
    def method_missing(name, *args)
      name = normalize_day_name(name)
      args.empty? || self[name] = args.shift
      self[name]
    end
    # rubocop:enable Style/MethodMissing

    def respond_to_missing?
      super
    end

    def find_day_by_date(date)
      date = normalize_date_format(date.to_date)
      @days.each do |_name, day|
        return day if date == normalize_date_format(day.date)
      end
      nil
    end

    private

    def sort_prices
      @prices.each do |price|
        day = find_day_by_date(price.date)
        day.prices << price if day
      end
    end

    def initialize_week_days
      weekly_menu = {}
      daynames = Date::DAYNAMES.dup
      daynames.push daynames.shift
      daynames.each_with_index do |name, i|
        date = first_week_day + i
        normalized_name = normalize_day_name(name)
        weekly_menu[normalized_name] = DailyMenu.new normalized_name, date
      end
      weekly_menu
    end

    def normalize_day_name(name)
      name.to_s.gsub(/(\w+)=/, '\1').downcase.to_sym
    end

    def normalize_date_format(date)
      date.strftime('%Y-%m-%d')
    end

    def first_week_day
      @first_week_day ||= (today - (today.strftime('%u').to_i - 1))
    end

    def today
      @today ||= Time.zone.today
    end
  end
end
