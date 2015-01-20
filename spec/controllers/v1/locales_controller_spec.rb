require "spec_helper"

describe V1::LocalesController, type: :controller do

  context "GET" do
    let(:user) { create :user }

    ### Some english locale at config/locales/en/base.yml
    let(:en_locale) { {"en" => {"hello" => "Hello %{first_name}"}}.to_yaml.to_s }

    ### Some Catalog, Foo at config/locales/en/catalogs/foo.yml
    let(:en_foo_locale) { {"en" => {"hello" => "Hello %{first_name}", "catalogs" => {"some_question" => "How fantastic do you feel today?"}}}.to_yaml.to_s }

    before(:each) do
      sign_in(user)
    end

    it "it translates properly into json" do
      allow(File).to receive(:open).and_return(Tempfile.new("temp"))
      allow_any_instance_of(File).to receive(:read).and_return(en_locale)

      get :show, {locale: "en"}
      expect(response.body).to be_json_eql ({en: {hello: "Hello {{first_name}}"}}.to_json)

      returns_code 200
    end

    it "it returns 404 for unknown locale" do
      get :show, {locale: "pirate"}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)
      returns_code 404
    end

    # it "it grabs a catalog and appends it to the output" do
    #   allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/catalogs/en_base.yml").and_return(Tempfile.new("temp"))
    #   allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/catalogs/foo.yml").and_return(Tempfile.new("temp"))
    #   allow_any_instance_of(File).to receive(:read).and_return(en_foo_locale)
    #
    #   user.update_attribute(:catalogs, [:foo])
    #
    #   get :show, {locale: :en, catalogs: [:foo]}
    #   expect(response.body).to be_json_eql ({en: {hello: "Hello {{first_name}}", catalogs: {foo: {some_question: "How fantastic do you feel today?"}}}}.to_json)
    #
    #   returns_code 200
    # end

    it "it returns 404 for unknown catalog" do
      allow(File).to receive(:open).and_call_original
      allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/catalogs/en_base.yml").and_return(Tempfile.new("temp"))
      allow_any_instance_of(File).to receive(:read).and_return(en_locale)
      allow_any_instance_of(User).to receive(:active_catalogs).and_return(["bar"])

      get :show, {locale: "en"}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)

      returns_code 404
    end

    it "crazy ass filenames are sanitized" do
      allow(File).to receive(:open).and_return(Tempfile.new("temp"))
      allow(File).to receive(:open).with("#{Rails.root}/config/locales//_base.yml").and_call_original

      get :show, {locale: "!!#$&"}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)
      returns_code 404

    end

  end

end