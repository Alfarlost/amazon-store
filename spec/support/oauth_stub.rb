module OauthStub
  def set_omniauth(opts = {})
    default = {:provider => :facebook,
               :uid     => "1234",
               :info => {
                          :email => "foobar@example.com",
                          :gender => "Male",
                          :first_name => "foo",
                          :last_name => "bar"
                        }
              }
  
    credentials = default.merge(opts)
    provider = credentials[:provider]
    user_hash = credentials[:info]
  
    OmniAuth.config.test_mode = true
  
    OmniAuth.config.mock_auth[provider] = OmniAuth::AuthHash.new({
      "provider" => provider,
      "uid" => credentials[:uid],
      "info" => {
        "email" => user_hash[:email],
        "first_name" => user_hash[:first_name],
        "last_name" => user_hash[:last_name],
        "gender" => user_hash[:gender]
        }
    })
  end

  def set_invalid_omniauth(opts = {})  
    credentials = OmniAuth::AuthHash.new({ :provider => :facebook,
                    :invalid  => :invalid_crendentials
                   }).merge(opts)
  
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]
  end
end 