class DashboardController < ApplicationController
  def index
    @study_sessions = StudySession.order(created_at: :desc).limit(10)
    @total_cards_studied = StudySession.sum(:cards_studied)
    @total_correct = StudySession.sum(:correct_count)
    @accuracy = @total_cards_studied > 0 ? ((@total_correct.to_f / @total_cards_studied) * 100).round(1) : 0
  end
end
