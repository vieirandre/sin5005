require 'rails_helper'

RSpec.describe "dados_fundos/new", type: :view do
  before(:each) do
    assign(:dados_fundo, DadosFundo.new(
      :codigoAtivo => "MyString",
      :rendimento => "MyString",
      :dataBase => "MyString",
      :diaPagamento => "MyString",
      :cnpj => "MyString"
    ))
  end

  it "renders new dados_fundo form" do
    render

    assert_select "form[action=?][method=?]", dados_fundos_path, "post" do

      assert_select "input[name=?]", "dados_fundo[codigoAtivo]"

      assert_select "input[name=?]", "dados_fundo[rendimento]"

      assert_select "input[name=?]", "dados_fundo[dataBase]"

      assert_select "input[name=?]", "dados_fundo[diaPagamento]"

      assert_select "input[name=?]", "dados_fundo[cnpj]"
    end
  end
end
