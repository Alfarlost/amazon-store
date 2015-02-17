class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @customer = Customer.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @customer
  end
end