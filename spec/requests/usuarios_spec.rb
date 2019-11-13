require 'rails_helper'

RSpec.describe "Usuarios", type: :request do
  describe "GET /usuarios" do
    it "works! (now write some real specs)" do
      get usuarios_path
      expect(response).to have_http_status(200)
    end
  end
end
