require 'rails_helper'

RSpec.describe "StudySessions", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/study_sessions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/study_sessions/create"
      expect(response).to have_http_status(:success)
    end
  end

end
