class Api::V1::UsersController < Api::ApiController
  def show
    user = User.find(params[:id])
    respond_with user
  end
end
