require 'rails_helper'

RSpec.describe "Fundos", type: :request do
  describe "GET /fundos" do
    it "works! (now write some real specs)" do
      get fundos_path
      expect(response).to have_http_status(200)
    end
  end
end
