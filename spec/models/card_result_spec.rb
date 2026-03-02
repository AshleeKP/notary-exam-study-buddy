require 'rails_helper'

RSpec.describe CardResult, type: :model do
  describe 'associations' do
    it { expect(CardResult.reflect_on_association(:study_session)).to be_a(ActiveRecord::Reflection::BelongsToReflection) }
    it { expect(CardResult.reflect_on_association(:card)).to be_a(ActiveRecord::Reflection::BelongsToReflection) }
  end
end
