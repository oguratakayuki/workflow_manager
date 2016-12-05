require 'rails_helper'

RSpec.describe "flow_grants/index", type: :view do
  before(:each) do
    assign(:flow_grants, [
      FlowGrant.create!(
        :order => 2,
        :grant_type => 3
      ),
      FlowGrant.create!(
        :order => 2,
        :grant_type => 3
      )
    ])
  end

  it "renders a list of flow_grants" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
