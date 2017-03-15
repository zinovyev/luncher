class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  protected

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash = nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
    auth = session['devise.google_data']
    self.resource = User.fill_from_omniauth(resource, auth) if auth
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
