class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.text_search(params[:query])
  end

  private

  def review_params
    params.require(:user).permit(:first_name, :last_name, :bio, :email, :avatar)
  end
end
