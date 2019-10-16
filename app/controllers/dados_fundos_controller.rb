class DadosFundosController < ApplicationController
  before_action :set_dados_fundo, only: [:show, :edit, :update, :destroy]

  # GET /dados_fundos
  # GET /dados_fundos.json
  def pegarCodigoEChamarScrap
    if(params.has_key?(:codigo))
      codigo = params[:codigo]
      puts "O CÓDIGO É: " + codigo
      if (codigo != "")
        listaFundos = DadosFundo.realizarScrapFii(codigo)
        DadosFundo.salvarFundo(codigo,listaFundos)
        return listaFundos
      else
        return "Erro: Nenhum código foi informado"
      end
    else
      return "Erro: Informe o código do ativo pelo parâmetro 'codigo'"
    end
  end

  def index
    @dados_fundos = DadosFundo.all
    @ngiri = pegarCodigoEChamarScrap
  end

  # GET /dados_fundos/1
  # GET /dados_fundos/1.json
  def show
  end

  # GET /dados_fundos/new
  def new
    @dados_fundo = DadosFundo.new
  end

  # GET /dados_fundos/1/edit
  def edit
  end

  # POST /dados_fundos
  # POST /dados_fundos.json
  def create
    @dados_fundo = DadosFundo.new(dados_fundo_params)

    respond_to do |format|
      if @dados_fundo.save
        format.html { redirect_to @dados_fundo, notice: 'Dados fundo was successfully created.' }
        format.json { render :show, status: :created, location: @dados_fundo }
      else
        format.html { render :new }
        format.json { render json: @dados_fundo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dados_fundos/1
  # PATCH/PUT /dados_fundos/1.json
  def update
    respond_to do |format|
      if @dados_fundo.update(dados_fundo_params)
        format.html { redirect_to @dados_fundo, notice: 'Dados fundo was successfully updated.' }
        format.json { render :show, status: :ok, location: @dados_fundo }
      else
        format.html { render :edit }
        format.json { render json: @dados_fundo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dados_fundos/1
  # DELETE /dados_fundos/1.json
  def destroy
    @dados_fundo.destroy
    respond_to do |format|
      format.html { redirect_to dados_fundos_url, notice: 'Dados fundo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dados_fundo
      @dados_fundo = DadosFundo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dados_fundo_params
      params.require(:dados_fundo).permit(:codigoAtivo, :rendimento, :diaDistribuicao, :precoAtivoNoFechamento, :diaFechamentoDoPreco)
    end
end
