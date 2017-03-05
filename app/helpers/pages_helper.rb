module PagesHelper
  def current_page
    page = request.query_parameters[:page].to_i
    page > 1 ? page : 1
  end

  def next_page
    current_page + 1
  end

  def prev_page
    current_page > 1 ? current_page - 1 : nil
  end
end
