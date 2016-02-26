require 'rails_helper'

describe PokemonType, type: :model do
  let(:pokemon_type){ build(:pokemon_type) }
  describe 'attributes' do
    it 'has_many pokemons' do
      expect(pokemon_type).to respond_to('pokemons')
    end

    it 'has_many defend_types' do
      expect(pokemon_type).to respond_to('defend_types')
    end

    it 'has_many attack_types' do
      expect(pokemon_type).to respond_to('attack_types')
    end
  end
end
