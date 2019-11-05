require 'rails_helper'

RSpec.describe "usuarios/index", type: :view do
  before(:each) do
    assign(:usuarios, [
      Usuario.create!(
        :login => "Login",
        :senha => "Senha",
        :nome => "Nome"
      ),
      Usuario.create!(
        :login => "Login",
        :senha => "Senha",
        :nome => "Nome"
      )
    ])
  end

  it "renders a list of usuarios" do
    render
    assert_select "tr>td", :text => "Login".to_s, :count => 2
    assert_select "tr>td", :text => "Senha".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
  end
end
