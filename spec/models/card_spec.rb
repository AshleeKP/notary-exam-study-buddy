require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:pamphlet_version) { PamphletVersion.create!(year: 2024) }

  describe 'associations' do
    it { expect(Card.reflect_on_association(:pamphlet_version)).to be_a(ActiveRecord::Reflection::BelongsToReflection) }
    it { expect(Card.reflect_on_association(:card_results)).to be_a(ActiveRecord::Reflection::HasManyReflection) }
  end

  describe 'validations' do
    it { expect(Card.new(pamphlet_version: pamphlet_version, question: nil, answer: 'test', topic: 'test')).not_to be_valid }
    it { expect(Card.new(pamphlet_version: pamphlet_version, question: 'test', answer: nil, topic: 'test')).not_to be_valid }
    it { expect(Card.new(pamphlet_version: pamphlet_version, question: 'test', answer: 'test', topic: nil)).not_to be_valid }
    it { expect(Card.new(pamphlet_version: pamphlet_version, question: 'test', answer: 'test', topic: 'test')).to be_valid }
  end
end
