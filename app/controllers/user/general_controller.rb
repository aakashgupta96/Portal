class User::GeneralController < ApplicationController
before_filter ->{ authenticate_user!( force: true )}, only: [:dashboard]  #Necessary to pass force:true to this

	def user_params
    	params.require(:user).permit(:name, :tag_list) ## Rails 4 strong params usage
  	end

  	def dashboard
    
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
end