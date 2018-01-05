# == Schema Information
#
# Table name: codes
#
#  id             :integer          not null, primary key
#  name           :string
#  value          :float
#  code_status_id :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Code < ApplicationRecord
  #associations
  belongs_to :user, required: false
  belongs_to :code_status, required: false, class_name: 'CodeStatus', primary_key: 'code', foreign_key: 'code_status_id'
  #calllbacks
  before_create :init_code

  def init_code
    self.name = SecureRandom.uuid
  end
end
