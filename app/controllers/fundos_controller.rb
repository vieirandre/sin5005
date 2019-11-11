class FundosController < ApplicationController
  protect_from_forgery with: :null_session, only: :popula

  def index
    @fundos = Fundo.all

    if @fundos.blank?
      render json: { status: 'Sucesso', message: 'Não há fundos salvos no banco', data: @fundos },
             status: :ok
    else
      render json: { status: 'Sucesso', message: 'Fundos carregados', data: @fundos },
             status: :ok
    end
  end

  def recupera
    ticker = params[:ticker].upcase
    trazFundo(ticker)

    if !@fundo.nil?
      render json: { status: 'Sucesso', message: 'Fundo carregado', data: @fundo },
             status: :ok
    else
      render json: { status: 'Não encontrado', message: "Fundo #{ticker} não encontrado" },
             status: :not_found
    end
  end

  def popula
    Fundo.popula
    index
  end

  def integra
    ticker = params[:ticker].upcase
    trazFundo(ticker)
    @lista_noticias = Noticias.lista(ticker)
  end

  private

  def trazFundo(ticker)
    @fundo = Fundo.find_by_ticker(ticker)

    if @fundo.nil?
      Fundo.scrap(ticker)
      @fundo = Fundo.find_by_ticker(ticker)
    end
  end
end