class UsersController < ApplicationController
  before_filter :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  private
  def review_params
    params.require(:user).permit(:first_name, :last_name, :bio, :email)
  end
end
