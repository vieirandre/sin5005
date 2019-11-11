class Usuario < ApplicationRecord
  has_secure_password
    validates :email, presence: true, uniqueness: true
end
