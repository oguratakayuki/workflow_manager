require 'rails_helper'

RSpec.describe "flows/new", type: :view do
  before(:each) do
    assign(:flow, Flow.new(
      :name => "MyString"
    ))
  end

  it "renders new flow form" do
    render

    assert_select "form[action=?][method=?]", flows_path, "post" do

      assert_select "input#flow_name[name=?]", "flow[name]"
    end
  end
end
