module RequireAdminConcern
  extend ActiveSupport::Concern

  included do
     before_action :require_admin
  end

  private

  # rubocop:disable Style/GuardClause
  def require_admin
    unless helpers.lunches_admin?
      flash[:danger] = 'Access Denied!'
      redirect_to root_path
    end
  end
  # rubocop:enable Style/GuardClause
end
