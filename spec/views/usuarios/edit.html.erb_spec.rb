require 'rails_helper'

RSpec.describe "usuarios/edit", type: :view do
  before(:each) do
    @usuario = assign(:usuario, Usuario.create!(
      :login => "MyString",
      :senha => "MyString",
      :nome => "MyString"
    ))
  end

  it "renders the edit usuario form" do
    render

    assert_select "form[action=?][method=?]", usuario_path(@usuario), "post" do

      assert_select "input[name=?]", "usuario[login]"

      assert_select "input[name=?]", "usuario[senha]"

      assert_select "input[name=?]", "usuario[nome]"
    end
  end
end
