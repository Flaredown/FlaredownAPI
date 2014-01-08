require "spec_helper"

feature "find a user's entries" do
  let(:user) { create :user }
    
  scenario "see it's glory" do
    entry = create :entry, user: user
    get entry_path(entry, api_credentials(user))
    expect(response.body).to be_json_eql EntrySerializer.new(entry).to_json
    returns_code 200
  end
  scenario "it isn't found" do
    get entry_path(999, api_credentials(user))
    expect_json_is_empty(response.body)
    returns_code 404
  end
end

feature "entry creation" do
  let(:user) { create :user }
  
  scenario "unauthenticated user" do
    post entries_path({entry: {weight_current: 123}})
    expect_not_authenticated
  end
  
  scenario "authenticated user creates entry" do
    post entries_path({entry: entry_attributes}.merge(api_credentials(user)))
    expect(json_response["entry"]["id"]).to eq 1
    expect(user.entries.first.stools).to eq entry_attributes["stools"]
    returns_code 201
  end
  
  scenario "missing something" do
    invalid_attrs = entry_attributes; invalid_attrs.delete("stools")
    post entries_path({entry: invalid_attrs}.merge(api_credentials(user)))
    expect(json_response["errors"].keys).to include("stools")
    returns_code 422
  end
end

feature "update a entry" do
  let!(:user) { login_with_user }
  
  context "authenticated" do
    let(:entry) { create :entry, user: user }
    scenario "successfully updated" do
      expect(entry.weight_current).to eq 140
      patch entry_path(entry, {entry: {weight_current: 200}}.merge(api_credentials(user)))
      expect(json_response["id"]).to eq 1
      expect(entry.reload.weight_current).to eq 200
      returns_code 200
    end
    
    scenario "blank required attribute" do
      expect(entry.weight_current).to eq 140
      patch entry_path(entry, {entry: {weight_current: ""}}.merge(api_credentials(user)))
      expect(entry.reload.weight_current).to eq 140
      returns_code 422
    end
    
  end
end

def entry_attributes
  {
    "stools"=>2,
    "ab_pain"=>1,
    "general"=>4,
    "complication_arthritis"=>true,
    "complication_iritis"=>false,
    "complication_erythema"=>true,
    "complication_fistula"=>false,
    "complication_other_fistula"=>false,
    "complication_fever"=>true,
    "opiates"=>false,
    "mass"=>2,
    "hematocrit"=>40,
    "weight_current"=>150
  }
end