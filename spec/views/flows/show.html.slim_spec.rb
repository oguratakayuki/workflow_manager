require 'rails_helper'

RSpec.describe "flows/show", type: :view do
  before(:each) do
    @flow = assign(:flow, Flow.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
