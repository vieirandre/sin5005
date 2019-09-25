class FundosController < ApplicationController
  before_action :set_fundo, only: [:show, :edit, :update, :destroy]

  # GET /fundos
  # GET /fundos.json
  def index
    @fundos = Fundo.all
  end

  # GET /fundos/1
  # GET /fundos/1.json
  def show
  end

  # GET /fundos/new
  def new
    @fundo = Fundo.new
  end

  # GET /fundos/1/edit
  def edit
  end

  # POST /fundos
  # POST /fundos.json
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

  # PATCH/PUT /fundos/1
  # PATCH/PUT /fundos/1.json
  def update
    respond_to do |format|
      if @fundo.update(fundo_params)
        format.html { redirect_to @fundo, notice: 'Fundo was successfully updated.' }
        format.json { render :show, status: :ok, location: @fundo }
      else
        format.html { render :edit }
        format.json { render json: @fundo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fundos/1
  # DELETE /fundos/1.json
  def destroy
    @fundo.destroy
    respond_to do |format|
      format.html { redirect_to fundos_url, notice: 'Fundo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fundo
      @fundo = Fundo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fundo_params
      params.require(:fundo).permit(:ticker, :nome, :cnpj, :segmento, :tx_adm, :data_const, :num_cotas_emitidas, :patrimonio_inicial, :valor_inicial_cota, :prazo, :tipo_gestao)
    end
end
