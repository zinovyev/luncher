module AggregateHelper
  def group_hash(hash)
    hash.each_with_object({}) do |obj, memo|
      group = yield obj
      memo[group] = [] unless memo[group]
      memo[group] << obj
    end
  end

  def group_menu(prices)
    group_hash(prices) do |price|
      price.item.course.to_sym
    end
  end
end
