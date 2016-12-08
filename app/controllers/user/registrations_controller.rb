class User::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
before_action :configure_account_update_params , only: [:update]
autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag' 
  
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
    #def create
    #   super
    #end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
   def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    allowed_params = configure_account_update_params
    resource_updated = update_resource(resource, allowed_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
   end
  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  #def configure_permitted_parameters
   # devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:contact_no])
  #end
  def update_resource(resource,params)
      resource.update_without_password(params)
  end
   
  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
      params[:user].permit(:first_name, :last_name,:tag_list,:avatar)
   end


   def after_update_path_for(resource)
      "/users/#{resource.username}"#show_profile_path(resource.username)
  end
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
