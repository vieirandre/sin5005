require 'rails_helper'

RSpec.describe "usuarios/index", type: :view do
  before(:each) do
    assign(:usuarios, [
      Usuario.create!(
        :email => "Email",
        :nome => "Nome",
        :password => "senha"
      ),
      Usuario.create!(
        :email => "Email",
        :nome => "Nome",
        :password => "senha"
      )
    ])
  end

  it "renders a list of usuarios" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
