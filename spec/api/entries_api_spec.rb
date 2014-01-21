require "spec_helper"

feature "find a user's entries" do
  let(:user) { create :user }
    
  scenario "see it's glory" do
    entry = create :cdai_entry, user: user
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
    post "/entries", {entry: entry_attributes}.merge(api_credentials(user)).to_json, data_is_json
    expect(user.entries.first.stools).to eq entry_attributes[:responses].select{|q| q[:name] == "stools"}.first[:value]
    expect(user.entries.first.date).to eq Date.today
    returns_code 201
  end
  
  scenario "returns nested errors for bad response values" do
    attrs = entry_attributes
    attrs[:responses].select{|q| q[:name] == "stools"}.first[:value] = 999999

    post "/entries", {entry: attrs}.merge(api_credentials(user)).to_json, data_is_json
    
    expect(json_response["errors"]).to be_present
    expect(json_response["errors"]["responses"]).to be_present
    expect(json_response["errors"]["responses"]["stools"]).to eq "Not within allowed values"
    
    returns_code 422
  end
  
  # scenario "missing something" do
  #   invalid_attrs = entry_attributes; invalid_attrs[:responses].delete("stools")
  #   post entries_path({entry: invalid_attrs}.merge(api_credentials(user)))
  #   expect(json_response["errors"].keys).to include("stools")
  #   returns_code 422
  # end
end

feature "update a entry" do
  let!(:user) { login_with_user }
  
  context "authenticated" do
    let(:entry) { create :cdai_entry, user: user }
    scenario "successfully updated" do
      expect(entry.weight_current).to eq 140
      
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "weight_current"}.first[:value] = 200

      patch "/entries/#{entry.id}", {entry: attrs}.merge(api_credentials(user)).to_json, data_is_json
      
      expect(entry.reload.weight_current).to eq 200
      returns_code 200
    end
    scenario "expect same ID in response as sent" do
      create :cdai_entry, user: user
      
      patch "/entries/#{entry.id}", {entry: entry_attributes}.merge(api_credentials(user)).to_json, data_is_json
      expect(json_response["id"]).to eq entry.id
      
      returns_code 200
    end
    scenario "successfully updated with true/false response" do
      entry.responses.select{|q| q.name == "opiates"}.first.value = 0
      expect(entry.opiates).to eq 0
      
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "opiates"}.first[:value] = 1
      
      
      patch "/entries/#{entry.id}", {entry: attrs}.merge(api_credentials(user)).to_json, data_is_json
      expect(entry.reload.opiates).to eq 1
      
      returns_code 200
    end
    
    # TODO enforce some attributes? currently there are none
    # scenario "blank required attribute" do
    #   expect(entry.weight_current).to eq 140
    #   patch entry_path(entry, {entry: {date: ""}}.merge(api_credentials(user)))
    #   expect(entry.reload.weight_current).to eq 140
    #   returns_code 422
    # end
    
  end
end

def response_attributes
  {
    "stools"=>2,
    "ab_pain"=>1,
    "general"=>4,
    "complication_arthritis"=>1,
    "complication_iritis"=>0,
    "complication_erythema"=>1,
    "complication_fistula"=>0,
    "complication_other_fistula"=>0,
    "complication_fever"=>1,
    "opiates"=>0,
    "mass"=>3,
    "hematocrit"=>40,
    "weight_current"=>140,
    "weight_typical"=>150
  }
end
def entry_attributes
  {
    catalogs: ["cdai"],
    responses: response_attributes.map{|r| {name: r.first, value: r.last}}
  }
end