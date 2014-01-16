require 'spec_helper'

describe Question do
  let(:question) { create :question, :select }
  describe "#name" do
    it "validates for badly formatted names" do
      question.name = "Some Crazy name"
      expect(question).to be_invalid
    end
  end
  
  describe "#options" do
    it "is a hash with specific attributes" do
      expect(question.options).to be_an Array
      expect(question.options[0]).to be_a Hash
      expect(question.options[0]).to have_key :value
      expect(question.options[0]).to have_key :label
      expect(question.options[0]).to have_key :meta_label
      expect(question.options[0]).to have_key :helper
    end
    describe "when kind is 'select'" do
      it "is invalid without multiple options" do
        question.options = []
        expect(question).to be_invalid
        question.options = [{value: 0, label: "none", meta_label: "happy_face", helper: nil}]
        expect(question).to be_invalid
        question.options = [{value: 0, label: "none", meta_label: "happy_face", helper: nil}, {value: 1, label: "some", meta_label: "neutral_face", helper: nil}]
        expect(question).to be_valid
      end
      it "is invalid without all required attributes present" do
        question.options[0].delete(:value)
        expect(question).to be_invalid
      end
    end

  end
  
end
