require 'rails_helper'

RSpec.describe StudySession, type: :model do
  describe 'associations' do
    it { expect(StudySession.reflect_on_association(:card_results)).to be_a(ActiveRecord::Reflection::HasManyReflection) }
    it { expect(StudySession.reflect_on_association(:cards)).to be_a(ActiveRecord::Reflection::ThroughReflection) }
  end

  describe 'validations' do
    it { expect(StudySession.new(study_date: nil)).not_to be_valid }
    it { expect(StudySession.new(study_date: Date.today)).to be_valid }
  end
end
