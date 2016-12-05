require 'rails_helper'

RSpec.describe "flow_grants/show", type: :view do
  before(:each) do
    @flow_grant = assign(:flow_grant, FlowGrant.create!(
      :order => 2,
      :grant_type => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
