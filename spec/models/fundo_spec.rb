require 'rails_helper'

RSpec.describe Fundo, type: :model do
  describe 'criação de um fundo' do
    it 'cria um fundo válido' do
      fundo = build(:fundo, ticker: 'abcp11')
      expect(fundo).to be_valid
    end
    it 'invalida criação de fundo' do
      fundo = build(:fundo)
      expect(fundo).to_not be_valid
    end
  end
end