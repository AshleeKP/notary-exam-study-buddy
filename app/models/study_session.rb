class StudySession < ApplicationRecord
  has_many :card_results, dependent: :destroy
  has_many :cards, through: :card_results
end
