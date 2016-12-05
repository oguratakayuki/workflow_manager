require 'rails_helper'

RSpec.describe "flows/edit", type: :view do
  before(:each) do
    @flow = assign(:flow, Flow.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit flow form" do
    render

    assert_select "form[action=?][method=?]", flow_path(@flow), "post" do

      assert_select "input#flow_name[name=?]", "flow[name]"
    end
  end
end
