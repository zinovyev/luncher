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
      @days[name] = menu if @days.has_key? name
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

    def method_missing(name, *args)
      name = normalize_day_name(name)
      unless args.empty?
        self[name] = args.shift
      end 
      self[name]
    end

    def find_day_by_date(date)
      date = normalize_date_format(date.to_date)
      @days.each do |name, day|
        if date == normalize_date_format(day.date)
          return day
        end
      end
      nil
    end

    private

    def sort_prices
      @prices.each do |price|
        if day = find_day_by_date(price.date)
          day.prices << price
        end
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
      @first_week_day ||= (today - ((today.strftime('%u')).to_i - 1))
    end

    def today
      @today ||= Date.today
    end
  end
end
