class UsersController < ApplicationController

  before_filter :authenticate_user!,  only: [:dashboard]

  
  def direct_root
    if current_user.nil?
      redirect_to new_user_session_path
    else
      redirect_to dashboard_path
    end
  end

  def dashboard

  end

  def profile
    @user = User.find_by_username(params[:username])
  end

  def add_owned_tag
    @user = User.find(params[:id])
    owned_tag_list = @some_item.all_tag_list - @some_item.tag_list
    owned_tag_list += [(params[:tag])]
    @tag_owner.tag(@some_item, :with => stringify(owned_tag_list), :on => :tags)
    @some_item.save
  end

  def stringify(tag_list)
    tag_list.inject('') { |memo, tag| memo += (tag + ',') }[0..-1]
  end

  protected

  def user_params
    params.require(:user).permit(:email, :contact_no, :first_name, :last_name, :username, :tag_list)
  end

end