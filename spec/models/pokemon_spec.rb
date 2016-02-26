require 'rails_helper'

describe Pokemon, type: :model do
  let(:pokemon){ build(:pokemon, first_type_id: PokemonType.find_by_name('grass').id) }

  describe 'attributes' do
    it 'creates with valid attributes' do
      PokemonType.create(name: 'grass')
      expect(pokemon).to be_valid
    end

    it "doesn't create with invalid name" do
      PokemonType.create(name: 'grass')
      expect{ create(:pokemon, name: nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'accessors' do
    it 'has_many profiles' do
      PokemonType.create(name: 'grass')
      expect(pokemon).to respond_to('profiles')
    end

    it 'belongs_to pokemon_type' do
      PokemonType.create(name: 'grass')
      expect(pokemon).to respond_to('pokemon_type')
    end

    it 'belongs_to second_type' do
      PokemonType.create(name: 'grass')
      expect(pokemon).to respond_to('second_type')
    end

    it 'belongs_to photo' do
      PokemonType.create(name: 'grass')
      expect(pokemon).to respond_to('photo')
    end
  end
end
