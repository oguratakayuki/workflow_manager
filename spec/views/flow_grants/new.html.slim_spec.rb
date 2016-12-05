require 'rails_helper'

RSpec.describe "flow_grants/new", type: :view do
  before(:each) do
    assign(:flow_grant, FlowGrant.new(
      :order => 1,
      :grant_type => 1
    ))
  end

  it "renders new flow_grant form" do
    render

    assert_select "form[action=?][method=?]", flow_grants_path, "post" do

      assert_select "input#flow_grant_order[name=?]", "flow_grant[order]"

      assert_select "input#flow_grant_grant_type[name=?]", "flow_grant[grant_type]"
    end
  end
end
