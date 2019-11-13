require 'rails_helper'

RSpec.describe Noticias, type: :model do

  let(:termo_valido) { 'knri11' }
  let(:termo_invalido) { '' }

  describe Noticias do
    it 'retorna uma lista de notícias' do
      @lista_noticias = Noticias.lista(termo_valido)
      expect(@lista_noticias).not_to be_empty
    end
    it 'retorna uma lista vazia' do
      @lista_noticias = Noticias.lista(termo_invalido)
      expect(@lista_noticias).to be_nil
    end
  end

end