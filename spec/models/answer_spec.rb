# spec/models/answer_spec.rb

require 'rails_helper'

RSpec.describe Answer, type: :model do
  # Let's assume you have other necessary associations set up, like Response, Question, and QuestionOption.
  let(:response) { create(:response) }
  let(:question) { create(:question) }
  let(:question_option) { create(:question_option) }

  let(:valid_answer) do
    Answer.new(
      response: response,
      question: question,
      question_option: question_option,
      text: "Some answer text"
    )
  end

  # describe "associations" do
  #   it { should belong_to(:response) }
  #   it { should belong_to(:question) }
  #   it { should belong_to(:question_option).optional }
  # end

  # describe "validations" do
  #   it "is valid with valid attributes" do
  #     expect(valid_answer).to be_valid
  #   end

  #   it "is not valid without a response" do
  #     valid_answer.response = nil
  #     expect(valid_answer).not_to be_valid
  #   end

  #   it "is not valid without a question" do
  #     valid_answer.question = nil
  #     expect(valid_answer).not_to be_valid
  #   end
  # end
end
