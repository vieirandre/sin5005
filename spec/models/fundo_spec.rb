require 'rails_helper'

RSpec.describe Fundo, type: :model do

  let(:valid_fundo) { build(:fundo, ticker: 'abcp11') }
  let(:invalid_fundo) { build(:fundo, ticker: nil) }

  describe 'criação de um fundo' do
    it 'cria um fundo válido' do
     expect(valid_fundo).to be_valid
    end
    it 'invalida criação de fundo' do
      expect(invalid_fundo).to_not be_valid
    end
  end

end