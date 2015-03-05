class SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  after_filter :set_settings, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected
  def set_settings
    current_order.set_customer(resource)
  end
  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
