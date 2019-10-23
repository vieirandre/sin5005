require 'rails_helper'

RSpec.describe NoticiasController, type: :controller do

	let(:id) { 'teste' }

	class Noticia 
		attr_accessor :titulo
  		attr_accessor :link
  		attr_accessor :descricao

  		def initialize(titulo, link, descricao)
    		@titulo = titulo
    		@link = link
    		@descricao = descricao
  		end
	end



	describe Noticia do
	  	it "Verificar classe" do
            noticia = Noticia.new(
                'teste', 
                'teste',
                'teste'
            )

            expect(noticia).to be_kind_of(Noticia)
        end

	end


end



