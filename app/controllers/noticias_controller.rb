


class NoticiasController < ApplicationController

	def fii

		@fii = params[:id]

		if (@fii != "") && (@fii)
			@lista_noticias = Noticias.lista(@fii)


		end
  
	end
end
