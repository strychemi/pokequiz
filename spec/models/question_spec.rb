require 'rails_helper'

describe Question, type: :model do
  let(:question) {build :question}
  let(:dup_question){build :question, category_id: 2 }

  context "invalid information" do
    it "question with an empty solution is invalid" do
      new_question = build( :question, solution: nil)
        expect( new_question ).not_to be_valid
    end

    it "question with an empty question is invalid" do
      new_question = build( :question, question: nil)
        expect( new_question ).not_to be_valid
    end

    it "question with an empty category is invalid" do
      new_question = build( :question, category: nil)
        expect( new_question ).not_to be_valid
    end

    it "question with an empty frequency is invalid" do
      new_question = build( :question, frequency: nil)
        expect( new_question ).not_to be_valid
    end

    it "question with a duplicate question is invalid" do
      question.save
      expect(dup_question).not_to be_valid
    end
  end

  context "associations" do
      it "a question has a category" do
        expect(question.category).not_to be_nil
      end
  end

end
