require 'rails_helper'

RSpec.describe "FlowGrants", type: :request do
  describe "GET /flow_grants" do
    it "works! (now write some real specs)" do
      get flow_grants_path
      expect(response).to have_http_status(200)
    end
  end
end
