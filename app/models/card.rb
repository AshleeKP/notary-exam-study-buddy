class Card < ApplicationRecord
  belongs_to :pamphlet_version
  has_many :card_results, dependent: :destroy

  validates :question, :answer, :topic, presence: true
end
