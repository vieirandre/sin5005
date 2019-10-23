require 'rails_helper'

RSpec.describe "fundos/index", type: :view do
  before(:each) do
    assign(:fundos, [
      Fundo.create!(
        :ticker => "Ticker",
        :nome => "Nome",
        :cnpj => "Cnpj",
        :segmento => "Segmento",
        :tx_adm => "Tx adm",
        :data_const => "Data const",
        :num_cotas_emitidas => "Num cotas emitidas",
        :patrimonio_inicial => "Patrimonio inicial",
        :valor_inicial_cota => "Valor inicial cota",
        :prazo => "Prazo",
        :tipo_gestao => "Tipo gestao"
      ),
      Fundo.create!(
        :ticker => "Ticker",
        :nome => "Nome",
        :cnpj => "Cnpj",
        :segmento => "Segmento",
        :tx_adm => "Tx adm",
        :data_const => "Data const",
        :num_cotas_emitidas => "Num cotas emitidas",
        :patrimonio_inicial => "Patrimonio inicial",
        :valor_inicial_cota => "Valor inicial cota",
        :prazo => "Prazo",
        :tipo_gestao => "Tipo gestao"
      )
    ])
  end

  it "renders a list of fundos" do
    render
    assert_select "tr>th", :text => "Ticker".to_s, :count => 1
    assert_select "tr>th", :text => "Nome".to_s, :count => 1
    assert_select "tr>th", :text => "Cnpj".to_s, :count => 1
    assert_select "tr>th", :text => "Segmento".to_s, :count => 1
    assert_select "tr>th", :text => "Tx adm".to_s, :count => 1
    assert_select "tr>th", :text => "Data const".to_s, :count => 1
    assert_select "tr>th", :text => "Num cotas emitidas".to_s, :count => 1
    assert_select "tr>th", :text => "Patrimonio inicial".to_s, :count => 1
    assert_select "tr>th", :text => "Valor inicial cota".to_s, :count => 1
    assert_select "tr>th", :text => "Prazo".to_s, :count => 1
    assert_select "tr>th", :text => "Tipo gestao".to_s, :count => 1
  end
end
