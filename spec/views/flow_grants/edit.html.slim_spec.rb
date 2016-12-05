require 'rails_helper'

RSpec.describe "flow_grants/edit", type: :view do
  before(:each) do
    @flow_grant = assign(:flow_grant, FlowGrant.create!(
      :order => 1,
      :grant_type => 1
    ))
  end

  it "renders the edit flow_grant form" do
    render

    assert_select "form[action=?][method=?]", flow_grant_path(@flow_grant), "post" do

      assert_select "input#flow_grant_order[name=?]", "flow_grant[order]"

      assert_select "input#flow_grant_grant_type[name=?]", "flow_grant[grant_type]"
    end
  end
end
