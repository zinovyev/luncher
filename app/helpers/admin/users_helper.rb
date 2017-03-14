module Admin
  module UsersHelper
    def resource
      @resourse || User.find(params[:id]) || User.new
    end

    def resource_name
      :user
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end
  end
end
