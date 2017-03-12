module UsersHelper
  def lunches_admin?
    signed_in? && current_user.lunches_admin?
  end

  def user_approved?
    signed_in? && current_user.approved?
  end
end
