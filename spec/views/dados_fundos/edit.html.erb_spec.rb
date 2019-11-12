require 'rails_helper'

RSpec.describe "dados_fundos/edit", type: :view do
  before(:each) do
    @dados_fundo = assign(:dados_fundo, DadosFundo.create!(
      :codigoAtivo => "MyString",
      :rendimento => "MyString",
      :dataBase => "MyString",
      :diaPagamento => "MyString",
      :cnpj => "MyString"
    ))
  end

  it "renders the edit dados_fundo form" do
    render

    assert_select "form[action=?][method=?]", dados_fundo_path(@dados_fundo), "post" do

      assert_select "input[name=?]", "dados_fundo[codigoAtivo]"

      assert_select "input[name=?]", "dados_fundo[rendimento]"

      assert_select "input[name=?]", "dados_fundo[dataBase]"

      assert_select "input[name=?]", "dados_fundo[diaPagamento]"

      assert_select "input[name=?]", "dados_fundo[cnpj]"
    end
  end
end
