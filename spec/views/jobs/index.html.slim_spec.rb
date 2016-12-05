require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
  before(:each) do
    assign(:jobs, [
      Job.create!(
        :name => "MyText",
        :flow_id => 2
      ),
      Job.create!(
        :name => "MyText",
        :flow_id => 2
      )
    ])
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
