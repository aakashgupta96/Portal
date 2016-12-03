class UsersController < ApplicationController

  before_filter ->{ authenticate_user!( force: true )}, only: [:dashboard]  #Necessary to pass force:true to this

  def dashboard

  end
  def user_params
    params.require(:user).permit(:name,:tag_list)
  end

end