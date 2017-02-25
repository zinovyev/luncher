module RequireAdminConcern
  extend ActiveSupport::Concern

  included do
    before_filter :require_admin
  end

  private

  def require_admin
    unless self.helpers.lunches_admin?
      flash[:danger] = 'Access Denied!'
      redirect_to root_path
    end
  end
end
