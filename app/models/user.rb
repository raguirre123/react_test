# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  last_name       :string
#  username        :string
#  email           :string
#  password_digest :string
#  city            :string
#  country         :string
#  uuid            :string
#  phone           :string
#  document        :string
#  last_login      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  #associations
  has_secure_password
  has_one :vault
  has_many :codes, dependent: :destroy
  #validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, :username, :password_digest, presence: true
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, format: { with: VALID_EMAIL_REGEX  }
  validates_confirmation_of :password
  #calllbacks
  before_create :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
