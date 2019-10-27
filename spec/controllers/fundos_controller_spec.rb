require 'rails_helper'

def json_response
  JSON.parse(response.body)
end

RSpec.describe FundosController, type: :controller do

  let(:valid_ticker) { 'abcp11' }
  let(:invalid_ticker) { 'xx11' }

  describe 'GET #index' do
    it 'retorna uma lista de fundos vazia' do
      get :index
      expect(response).to be_successful
      expect(json_response['data']).to be_empty
    end
    it 'retorna uma lista de fundos não-vazia' do
      FactoryBot.create_list(:fundo, 3, ticker: valid_ticker)
      get :index
      expect(response).to be_successful
      expect(json_response['data']).to_not be_empty
      expect(json_response['data'].length).to eq(3)
    end
  end

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