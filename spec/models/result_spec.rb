require 'rails_helper'

describe Result, type: :model do
  let(:result) { build :result}

  let(:user) {build :user}
  let(:question){build :question}
  let(:catogry){build :category}

  # before do
  #   result.user = user
  #   result.question = question
  # end

  context "creating a result" do
    context "validation information" do
      it "default result is valid" do
        new_result = build(:result, user: user, question: question)
        expect(new_result).to be_valid
      end
    end
  end
 
  context "invalid information" do
    it "result with no user is invalid" do
      new_result = build(:result, user: nil) 
      expect(new_result).not_to be_valid
    end

    it "result with no question is invalid" do
      new_result = build(:result, question: nil)
      expect(new_result).not_to be_valid
    end

    it "result with result not true|| false is invalid" do
      new_result = build(:result, result: "yellow")
      expect(new_result).not_to be_valid
    end
  end

  context "associations" do
    it "result has a user" do
      expect(result).to respond_to("user")
    end

    it "result has a question" do
      expect(result).to respond_to("question")
    end

  end


end
