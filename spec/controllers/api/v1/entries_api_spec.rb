require "spec_helper"

describe Api::V1::EntriesController, type: :controller do
  
  let(:user) { create :user }
  before(:each) do
    sign_in(user)
    @request.env["HTTP_ACCEPT"] = "application/json"
  end
  
  context "find a user's entries" do  
    it "see it's glory" do
      entry = create :cdai_entry, user: user
      with_resque{entry.save}; entry.reload
      get :show, id: entry.id
      expect(response.body).to be_json_eql EntrySerializer.new(entry).to_json
      returns_code 200
    end
    it "it isn't found" do
      get :show, id: 999
      expect(response.body).to be_json_eql({error: "Not found."}.to_json)
      returns_code 404
    end
  end

  context "entry creation" do

    # it "unauthenticated user" do
    #   post :create, {entry: {weight_current: 123}}
    #   expect_not_authenticated
    # end
  
    it "authenticated user creates entry" do
      post :create, entry: entry_attributes.to_json
      expect(user.entries.first.stools).to eq entry_attributes[:responses].select{|q| q[:name] == "stools"}.first[:value]
      expect(user.entries.first.date).to eq Date.today
      returns_code 201
    end
  
    it "returns nested errors for bad response values" do
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "stools"}.first[:value] = 999999

      post :create, entry: attrs.to_json
    
      expect(json_response["errors"]).to be_present
      expect(json_response["errors"]["responses"]).to be_present
      expect(json_response["errors"]["responses"]["stools"]).to eq "Not within allowed values"
    
      returns_code 422
    end
  
    # it "missing something" do
    #   invalid_attrs = entry_attributes; invalid_attrs[:responses].delete("stools")
    #   post entries_path({entry: invalid_attrs}.merge(api_credentials(user)))
    #   expect(json_response["errors"].keys).to include("stools")
    #   returns_code 422
    # end
  end

  context "update a entry" do
  
    let(:entry) { create :cdai_entry, user: user }
    it "successfully updated" do
      expect(entry.weight_current).to eq 140
    
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "weight_current"}.first[:value] = 200

      put :update, id: entry.id, entry: attrs.to_json
    
      expect(entry.reload.weight_current).to eq 200
      returns_code 200
    end
    it "expect same ID in response as sent" do
      create :cdai_entry, user: user
    
      patch :update, id: entry.id, entry: entry_attributes.to_json
      expect(json_response["id"]).to eq entry.id
    
      returns_code 200
    end
    it "successfully updated with true/false response" do
      entry.responses.select{|q| q.name == "opiates"}.first.value = 0
      expect(entry.opiates).to eq 0
    
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "opiates"}.first[:value] = 1
    
    
      patch :update, id: entry.id, entry: attrs.to_json
      expect(entry.reload.opiates).to eq 1
    
      returns_code 200
    end
  
    it "response with bad value" do
      attrs = entry_attributes
      attrs[:responses].select{|q| q[:name] == "opiates"}.first[:value] = "valuenogood"
    
      patch :update, id: entry.id, entry: attrs.to_json
      returns_code 422
    end
  
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
    "mass"=>2,
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