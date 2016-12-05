require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      :name => "MyText",
      :flow_id => 1
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "textarea#job_name[name=?]", "job[name]"

      assert_select "input#job_flow_id[name=?]", "job[flow_id]"
    end
  end
end
