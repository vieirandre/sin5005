require 'rails_helper'

RSpec.describe "dados_fundos/index", type: :view do
  before(:each) do
    assign(:dados_fundos, [
      DadosFundo.create!(
        :codigoAtivo => "Codigo Ativo",
        :rendimento => "Rendimento",
        :diaDistribuicao => "Dia Distribuicao",
        :precoAtivoNoFechamento => "Preco Ativo No Fechamento",
        :diaFechamentoDoPreco => "Dia Fechamento Do Preco"
      ),
      DadosFundo.create!(
        :codigoAtivo => "Codigo Ativo",
        :rendimento => "Rendimento",
        :diaDistribuicao => "Dia Distribuicao",
        :precoAtivoNoFechamento => "Preco Ativo No Fechamento",
        :diaFechamentoDoPreco => "Dia Fechamento Do Preco"
      )
    ])
  end

  it "renders a list of dados_fundos" do
    render
    assert_select "tr>td", :text => "Codigo Ativo".to_s, :count => 2
    assert_select "tr>td", :text => "Rendimento".to_s, :count => 2
    assert_select "tr>td", :text => "Dia Distribuicao".to_s, :count => 2
    assert_select "tr>td", :text => "Preco Ativo No Fechamento".to_s, :count => 2
    assert_select "tr>td", :text => "Dia Fechamento Do Preco".to_s, :count => 2
  end
end
