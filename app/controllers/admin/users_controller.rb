module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:edit, :update, :destroy]
    helper Admin::UsersHelper, DeviseHelper

    def index
      @users = User.all
    end

    def edit
    end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @admin_user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_path, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :name, :email, :approved, :organization_id)
    end
  end
end
