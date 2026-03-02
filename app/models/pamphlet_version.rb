class PamphletVersion < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :year, presence: true
end
