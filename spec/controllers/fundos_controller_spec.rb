require 'rails_helper'

RSpec.describe FundosController, type: :controller do

  let(:valid_ticker) { 'abcp11' }
  let(:invalid_ticker) { 'xx11' }

  describe 'GET #recupera' do
    it 'retorna uma resposta de sucesso' do
      get :recupera, params: { ticker: valid_ticker }
      expect(response).to be_successful
    end
    it 'retorna uma resposta de erro' do
      get :recupera, params: { ticker: invalid_ticker }
      expect(response).to have_http_status(:not_found)
    end
  end

end