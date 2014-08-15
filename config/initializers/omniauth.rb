Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, fields: [:screen_name, :email], model: User
end
