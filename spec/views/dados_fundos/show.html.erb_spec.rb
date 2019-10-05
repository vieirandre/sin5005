require 'rails_helper'

RSpec.describe "dados_fundos/show", type: :view do
  before(:each) do
    @dados_fundo = assign(:dados_fundo, DadosFundo.create!(
      :codigoAtivo => "Codigo Ativo",
      :rendimento => "Rendimento",
      :diaDistribuicao => "Dia Distribuicao",
      :precoAtivoNoFechamento => "Preco Ativo No Fechamento",
      :diaFechamentoDoPreco => "Dia Fechamento Do Preco"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Codigo Ativo/)
    expect(rendered).to match(/Rendimento/)
    expect(rendered).to match(/Dia Distribuicao/)
    expect(rendered).to match(/Preco Ativo No Fechamento/)
    expect(rendered).to match(/Dia Fechamento Do Preco/)
  end
end
