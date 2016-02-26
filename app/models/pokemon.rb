class Pokemon < ActiveRecord::Base
  has_many :profiles
  belongs_to :pokemon_type, foreign_key: :first_type_id
  belongs_to :second_type, class_name: "PokemonType", foreign_key: :second_type_id

  def first_type
    PokemonType.find(self.first_type_id)
  end

  def second_type
    second_type_id ? PokemonType.find(self.second_type_id) : nil
  end

  def types
    # TODO: Possible refactor
    first_type + second_type
  end
end
