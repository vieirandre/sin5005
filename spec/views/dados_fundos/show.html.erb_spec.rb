require 'rails_helper'

RSpec.describe "dados_fundos/show", type: :view do
  before(:each) do
    @dados_fundo = assign(:dados_fundo, DadosFundo.create!(
      :codigoAtivo => "Codigo Ativo",
      :rendimento => "Rendimento",
      :dataBase => "Data Base",
      :diaPagamento => "Dia Pagamento",
      :cnpj => "CNPJ"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Codigo Ativo/)
    expect(rendered).to match(/Rendimento/)
    expect(rendered).to match(/Data Base/)
    expect(rendered).to match(/Dia Pagamento/)
    expect(rendered).to match(/CNPJ/)
  end
end
