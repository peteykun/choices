class User < ActiveRecord::Base
  validates_presence_of    :email, :username, :name, :college, :phone
  validates                :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates                :username, length: { maximum: 8 }
  validates                :is_admin, inclusion: { in: [true, false] }
  validates_uniqueness_of  :email, :username

  has_many :answers
  has_secure_password
end
