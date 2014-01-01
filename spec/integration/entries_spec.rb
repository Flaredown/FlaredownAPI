require "spec_helper"

feature "Entries" do
  
  let(:user) { create :user }
  before(:each) do
    login
    expect(page).to have_content ""
  end  

end

