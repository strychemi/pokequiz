require 'rails_helper'

describe UserPresenter do
  let(:user){create(:user)}
  let(:view){ ActionView::Base.new}
  let(:pokemon){create(:pokemon)}
  let(:presenter){UserPresenter.new(user, view)}

  describe '#username' do

    it 'returns username from profile' do
      expect(presenter.username).to eq(user.profile.username)
    end

    it 'returns n/a if username is nil' do
      user.profile.username = nil
      expect(presenter.username).to eq("N/A")
    end
  end

  describe '#pokemon_name' do

    it 'returns favorite pokemon_name from profile' do
      user.profile.pokemon = pokemon
      expect(presenter.pokemon_name).to eq(user.profile.pokemon.name.capitalize)
    end

    it 'returns n/a if pokemon_name is nil' do
      user.profile.pokemon = nil
      expect(presenter.pokemon_name).to eq("N/A")
    end
  end

  describe '#pokemon_type' do

    it 'returns favorite pokemon_type from profile' do
      user.profile.pokemon = pokemon
      expect(presenter.pokemon_type).to eq(user.profile.pokemon.pokemon_type.name.capitalize)
    end

    it 'returns n/a if pokemon_name is nil' do
      user.profile.pokemon = nil
      expect(presenter.pokemon_type).to eq("N/A")
    end
  end

end