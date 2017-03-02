module AggregateHelper
  def group_hash(hash, &evaluator)
    hash.reduce({}) do |memo, obj|
      group = yield obj
      memo[group] = [] unless memo[group]
      memo[group] << obj
      memo
    end
  end

  def group_menu(prices)
    group_hash(prices) do |price|
      price.item.course.to_sym
    end
  end
end
