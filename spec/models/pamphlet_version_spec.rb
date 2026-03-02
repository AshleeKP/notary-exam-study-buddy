require 'rails_helper'

RSpec.describe PamphletVersion, type: :model do
  describe 'associations' do
    it { expect(PamphletVersion.reflect_on_association(:cards)).to be_a(ActiveRecord::Reflection::HasManyReflection) }
  end

  describe 'validations' do
    it { expect(PamphletVersion.new(year: nil)).not_to be_valid }
    it { expect(PamphletVersion.new(year: 2024)).to be_valid }
  end
end
