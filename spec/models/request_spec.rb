require 'rails_helper'

RSpec.describe Request, type: :model do
  it "is valid with title" do
    request = build(:request)
    expect(request.title).to eq 'hoge'
  end
end
