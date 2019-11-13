require 'rails_helper'

RSpec.describe Fundo, type: :model do

  let(:valid_fundo) { build(:fundo, ticker: 'abcp11') }
  let(:invalid_fundo) { build(:fundo, ticker: nil) }

  describe 'validação de um fundo' do
    it 'valida um fundo' do
      expect(valid_fundo).to be_valid
    end
    it 'invalida um fundo' do
      expect(invalid_fundo).to_not be_valid
    end
  end

  describe 'salvar fundo no banco' do
    it 'tenta salvar fundo inválido' do
      expect { Fundo.salva(invalid_fundo) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'tenta salvar fundo válido' do
      expect(Fundo.salva(valid_fundo)).to be_truthy
    end
  end

  describe 'popula banco com os fundos' do
    it 'recupera fundos e salva no banco' do
      Fundo.popula(3)
      fundos = Fundo.all
      expect(fundos.length).to eq(3)
    end
  end

end