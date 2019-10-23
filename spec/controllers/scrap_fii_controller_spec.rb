require 'rails_helper'

RSpec.describe ScrapFiiController, type: :controller do

  describe "GET #scrapFii" do
    it "returns http success" do
      get :scrapFii
      expect(response).to have_http_status(:success)
    end
  end

end
