class PublicOrganizationValidator < ActiveModel::Validator
  # rubocop:disable Style/GuardClause
  def validate(user)
    if user.organization && !user.organization.public? && !user.lunches_admin?
      user.errors[:organization] << "Organization #{user.organization.title} is not allowed for the user"
    end
  end
  # rubocop:enable Style/GuardClause
end
