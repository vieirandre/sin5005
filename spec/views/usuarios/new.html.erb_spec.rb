require 'rails_helper'

RSpec.describe "usuarios/new", type: :view do
  before(:each) do
    assign(:usuario, Usuario.new(
      :login => "MyString",
      :senha => "MyString",
      :nome => "MyString"
    ))
  end

  it "renders new usuario form" do
    render

    assert_select "form[action=?][method=?]", usuarios_path, "post" do

      assert_select "input[name=?]", "usuario[login]"

      assert_select "input[name=?]", "usuario[senha]"

      assert_select "input[name=?]", "usuario[nome]"
    end
  end
end
