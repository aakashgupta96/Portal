module UsersHelper

  def user_image_url user
    if @user.avatar.url.nil?
      "thumb_default_pic.jpg"
    else
      @user.avatar.url(:thumb)
    end
  end

  def set_skills
    if @user.tag_list.count == 0
      ""
    else
      array= Array.new
      @user.tag_list.each do |tag|
        temp = "#{tag}, "
        array << temp
      end

      array
    end
  end
end
