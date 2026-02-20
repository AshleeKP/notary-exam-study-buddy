class PamphletVersion < ApplicationRecord
  has_many :cards, dependent: :destroy
end
