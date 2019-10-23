require 'rails_helper'

RSpec.describe "fundos/edit", type: :view do
  before(:each) do
    @fundo = assign(:fundo, Fundo.create!(
      :ticker => "MyString",
      :nome => "MyString",
      :cnpj => "MyString",
      :segmento => "MyString",
      :tx_adm => "",
      :data_const => "MyString",
      :num_cotas_emitidas => "",
      :patrimonio_inicial => "",
      :valor_inicial_cota => "",
      :prazo => "MyString",
      :tipo_gestao => "MyString"
    ))
  end

  it "renders the edit fundo form" do
    render

    assert_select "form[action=?][method=?]", fundo_path(@fundo), "post" do

      assert_select "input[name=?]", "fundo[ticker]"

      assert_select "input[name=?]", "fundo[nome]"

      assert_select "input[name=?]", "fundo[cnpj]"

      assert_select "input[name=?]", "fundo[segmento]"

      assert_select "input[name=?]", "fundo[tx_adm]"

      assert_select "input[name=?]", "fundo[data_const]"

      assert_select "input[name=?]", "fundo[num_cotas_emitidas]"

      assert_select "input[name=?]", "fundo[patrimonio_inicial]"

      assert_select "input[name=?]", "fundo[valor_inicial_cota]"

      assert_select "input[name=?]", "fundo[prazo]"

      assert_select "input[name=?]", "fundo[tipo_gestao]"
    end
  end
end
