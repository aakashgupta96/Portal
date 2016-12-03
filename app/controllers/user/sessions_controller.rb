class User::SessionsController < Devise::SessionsController
  # When signed in, I want flow to reach new function, but before_action defined in Devise::SessionController is redirecing it to after_sign_up_path before even reaching to any other before_action defined in this class.
  before_action :go_to_byebug , only: [:new]
# before_action :configure_sign_in_params, only: [:create]
 # GET /resource/sign_in
 #    def new
 #      #byebug
 #      super
 #   end

  # POST /resource/sign_in
  #  def create
  #    #byebug
  #    super
  #  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
protected

  def go_to_byebug
    #byebug
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
