require 'rails_helper'

describe Category, type: :model do
  let(:category){ build(:category) }

  describe 'attributes' do
    it 'creates with name' do
      expect(category.name).to eq('photo')
    end

    it "can't create without name" do
      expect{ create(:category, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "can't create with duplicate name" do
      category.save
      expect{ create(:category) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'associations' do
    it 'has_many questions' do
      expect(category).to respond_to('questions')
    end
  end
end
