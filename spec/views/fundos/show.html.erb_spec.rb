require 'rails_helper'

RSpec.describe "fundos/show", type: :view do
  before(:each) do
    @fundo = assign(:fundo, Fundo.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Ticker/)
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Cnpj/)
    expect(rendered).to match(/Segmento/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Data Const/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Prazo/)
    expect(rendered).to match(/Tipo Gestao/)
  end
end
