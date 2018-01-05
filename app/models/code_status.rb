# == Schema Information
#
# Table name: code_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CodeStatus < ApplicationRecord
end
