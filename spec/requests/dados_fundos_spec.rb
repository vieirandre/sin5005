require 'rails_helper'

RSpec.describe "DadosFundos", type: :request do
  describe "GET /dados_fundos" do
    it "works! (now write some real specs)" do
      get dados_fundos_path
      expect(response).to have_http_status(200)
    end
  end
end
