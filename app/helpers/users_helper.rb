module UsersHelper
  def lunches_admin?
    signed_in? && current_user.lunches_admin?
  end
end
