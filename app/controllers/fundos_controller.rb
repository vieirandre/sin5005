class FundosController < ApplicationController
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
    @fundo = Fundo.find_by_ticker(ticker)

    if @fundo.nil?
      Fundo.scrap(ticker)
      @fundo = Fundo.find_by_ticker(ticker)
    end

    if !@fundo.nil?
      render json: { status: 'Sucesso', message: 'Fundo carregado', data: @fundo },
             status: :ok
    else
      render json: { status: 'Não encontrado', message: "Fundo #{ticker} não encontrado" },
             status: :not_found
    end
  end

  def create
    @fundo = Fundo.new(fundo_params)

    respond_to do |format|
      if @fundo.save
        format.html { redirect_to @fundo, notice: 'Fundo was successfully created.' }
        format.json { render :show, status: :created, location: @fundo }
      else
        format.html { render :new }
        format.json { render json: @fundo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @fundo.destroy
    respond_to do |format|
      format.html { redirect_to fundos_url, notice: 'Fundo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def fundo_params
    params.require(:fundo).permit(:ticker, :nome, :cnpj, :segmento, :tx_adm,
                                  :data_const, :num_cotas_emitidas, :patrimonio_inicial,
                                  :valor_inicial_cota, :prazo, :tipo_gestao)
  end
end