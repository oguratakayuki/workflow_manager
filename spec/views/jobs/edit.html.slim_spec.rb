require 'rails_helper'

RSpec.describe "jobs/edit", type: :view do
  before(:each) do
    @job = assign(:job, Job.create!(
      :name => "MyText",
      :flow_id => 1
    ))
  end

  it "renders the edit job form" do
    render

    assert_select "form[action=?][method=?]", job_path(@job), "post" do

      assert_select "textarea#job_name[name=?]", "job[name]"

      assert_select "input#job_flow_id[name=?]", "job[flow_id]"
    end
  end
end
