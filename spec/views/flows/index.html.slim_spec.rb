require 'rails_helper'

RSpec.describe "flows/index", type: :view do
  before(:each) do
    assign(:flows, [
      Flow.create!(
        :name => "Name"
      ),
      Flow.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of flows" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
