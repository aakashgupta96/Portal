class UsersController < ApplicationController

  before_filter ->{ authenticate_user!( force: true )}, only: [:dashboard]

  def dashboard

  end

  def profile
    @user = User.find_by_username(params[:username])
  end

  def user_params
    params.require(:user).permit( :email, :contact_no, :first_name, :last_name, :username,:tag_list)
  end

end