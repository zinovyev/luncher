module Admin
  class UsersController < AdminController
    before_action :set_user, only: [:edit, :update, :destroy]

    def index
      @users = User.all
    end

    def edit
    end

    def update
      respond_to do |format|
        if @admin_user.update(admin_user_params)
          format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_user }
        else
          format.html { render :edit }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @admin_user.destroy
      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.fetch(:user, {})
      end
  end
end
