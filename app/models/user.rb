class User < ApplicationRecord
  has_secure_password

  enum role: [:user, :admin]
end
