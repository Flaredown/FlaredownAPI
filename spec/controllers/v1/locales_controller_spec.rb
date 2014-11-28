require "spec_helper"

describe V1::LocalesController, type: :controller do

  context "GET" do
    let(:user) { create :user }

    ### Some english locale at config/locales/en/base.yml
    let(:en_locale) { {en: {hello: "Hello %{first_name}"}}.to_yaml }

    ### Some Catalog, Foo at config/locales/en/catalogs/foo.yml
    let(:foo_locale) { {some_question: "How fantastic do you feel today?"}.to_yaml }

    before(:each) do
      sign_in(user)

      allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/en_base.yml").and_return(en_locale)
      allow(File).to receive(:open).with("#{Rails.root}/config/locales/pirate/pirate_base.yml").and_call_original

      allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/catalogs/foo.yml").and_return(foo_locale)
      allow(File).to receive(:open).with("#{Rails.root}/config/locales/en/catalogs/bar.yml").and_call_original
    end

    it "it translates properly into json" do
      get :show, {locale: :en}
      expect(response.body).to be_json_eql ({en: {hello: "Hello {{first_name}}"}}.to_json)

      returns_code 200
    end

    it "it returns 404 for unknown locale" do
      get :show, {locale: :pirate}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)
      returns_code 404
    end

    it "it grabs a catalog and appends it to the output" do
      user.update_attribute(:catalogs, [:foo])

      get :show, {locale: :en, catalogs: [:foo]}
      expect(response.body).to be_json_eql ({en: {hello: "Hello {{first_name}}", catalogs: {foo: {some_question: "How fantastic do you feel today?"}}}}.to_json)

      returns_code 200
    end

    it "it returns 404 for unknown catalog" do
      user.update_attribute(:catalogs, [:bar])

      get :show, {locale: :en}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)

      returns_code 404
    end

    it "crazy ass filenames are sanitized" do
      allow(File).to receive(:open).with("#{Rails.root}/config/locales//_base.yml").and_call_original

      get :show, {locale: "!!#$&"}
      expect(response.body).to be_json_eql({error: "Unknown locale or catalog locale."}.to_json)
      returns_code 404

      get :show, {locale: "en%%%"}
      expect(response.body).to be_json_eql ({en: {hello: "Hello {{first_name}}"}}.to_json)
      returns_code 200
    end

  end

end