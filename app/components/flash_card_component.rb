# frozen_string_literal: true

class FlashCardComponent < ViewComponent::Base
  def initialize(card:, study_session:)
    @card = card
    @study_session = study_session
  end
end
