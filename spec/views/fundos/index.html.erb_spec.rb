require 'rails_helper'

RSpec.describe "fundos/index", type: :view do
  before(:each) do
    assign(:fundos, [
      Fundo.create!(
        :ticker => "Ticker",
        :nome => "Nome",
        :cnpj => "Cnpj",
        :segmento => "Segmento",
        :tx_adm => "",
        :data_const => "Data Const",
        :num_cotas_emitidas => "",
        :patrimonio_inicial => "",
        :valor_inicial_cota => "",
        :prazo => "Prazo",
        :tipo_gestao => "Tipo Gestao"
      ),
      Fundo.create!(
        :ticker => "Ticker",
        :nome => "Nome",
        :cnpj => "Cnpj",
        :segmento => "Segmento",
        :tx_adm => "",
        :data_const => "Data Const",
        :num_cotas_emitidas => "",
        :patrimonio_inicial => "",
        :valor_inicial_cota => "",
        :prazo => "Prazo",
        :tipo_gestao => "Tipo Gestao"
      )
    ])
  end

  it "renders a list of fundos" do
    render
    assert_select "tr>td", :text => "Ticker".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Cnpj".to_s, :count => 2
    assert_select "tr>td", :text => "Segmento".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Data Const".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Prazo".to_s, :count => 2
    assert_select "tr>td", :text => "Tipo Gestao".to_s, :count => 2
  end
end
