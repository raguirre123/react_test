# == Schema Information
#
# Table name: vaults
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  value      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vault < ApplicationRecord
  #associations
  belongs_to :user
  #calllbacks
  before_create :generate_uuid

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
