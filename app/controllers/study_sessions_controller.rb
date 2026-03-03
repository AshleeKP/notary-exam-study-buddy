class StudySessionsController < ApplicationController
  def show
    @study_session = StudySession.find(params[:id])
    @current_card = next_card
    @progress = calculate_progress
  end

  def create
    pamphlet_version = PamphletVersion.find(params[:pamphlet_version_id])
    @study_session = StudySession.create!(
      study_date: Date.today,
      cards_studied: 0,
      correct_count: 0
    )
    
    # Store card IDs in session to track progress
    session[:card_ids] = pamphlet_version.cards.pluck(:id).shuffle
    session[:current_card_index] = 0
    
    redirect_to study_session_path(@study_session)
  end

  def answer
    @study_session = StudySession.find(params[:id])
    card = Card.find(params[:card_id])
    is_correct = params[:is_correct] == 'true'
    
    # Record the result
    @study_session.card_results.create!(
      card: card,
      is_correct: is_correct
    )
    
    # Update session stats
    @study_session.update!(
      cards_studied: @study_session.cards_studied + 1,
      correct_count: @study_session.correct_count + (is_correct ? 1 : 0)
    )
    
    # Move to next card
    session[:current_card_index] = (session[:current_card_index] || 0) + 1
    
    redirect_to study_session_path(@study_session)
  end

  private

  def next_card
    card_ids = session[:card_ids] || []
    current_index = session[:current_card_index] || 0
    
    return nil if current_index >= card_ids.length
    
    Card.find(card_ids[current_index])
  end

  def calculate_progress
    card_ids = session[:card_ids] || []
    current_index = session[:current_card_index] || 0
    
    {
      current: [current_index + 1, card_ids.length].min,
      total: card_ids.length,
      percentage: card_ids.length > 0 ? ((current_index.to_f / card_ids.length) * 100).round : 0
    }
  end
end
