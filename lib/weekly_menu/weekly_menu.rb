require 'date'

module WeeklyMenu
  class WeeklyMenu
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

    def method_missing(name, *args)
      name = normalize_day_name(name)
      unless args.empty?
        self[name] = args.shift
      end 
      self[name]
    end

    private

    def initialize_week_days
      weekly_menu = {}
      Date::DAYNAMES.each_with_index do |name, i|
        date = first_week_day + i
        weekly_menu[normalize_day_name(name)] = DailyMenu.new date
      end
      weekly_menu
    end

    def normalize_day_name(name)
      name.to_s.gsub(/(\w+)=/, '\1').downcase.to_sym
    end

    def first_week_day
      @first_week_day ||= (today - ((today.strftime('%u')).to_i - 1))
    end

    def today
      @today ||= Date.today
    end
  end
end
