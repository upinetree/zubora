class User < OmniAuth::Identity::Models::ActiveRecord
  validates :email,           presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :screen_name,     presence:      true,
                              uniqueness:    true,
                              format: { with: /\A[a-z0-9_]+\z/i, message: "は半角英数'_'を使用してください。"},
                              length: { in: 3..20 }

  auth_key 'screen_name'
end
