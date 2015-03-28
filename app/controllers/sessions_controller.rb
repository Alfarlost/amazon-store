class SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]
  after_filter :reset_order, only: [:create]

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
  def reset_order
    session[:order_id] = nil
  end
  # You can put the params you want to permit in the empty array.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
