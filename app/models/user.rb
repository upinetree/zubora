class User < OmniAuth::Identity::Models::ActiveRecord
  auth_key 'screen_name'
end
