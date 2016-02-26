class PokemonType < ActiveRecord::Base
  has_many :pokemons

  has_many :attack_relationships, foreign_key: :attack_type_id, class_name: 'TypeRelationship', dependent: :destroy
  has_many :defend_types, through: :attack_relationships, class_name: 'PokemonType'

  has_many :defend_relationships, foreign_key: :defend_type_id, class_name: 'TypeRelationship', dependent: :destroy
  has_many :attack_types, through: :defend_relationships, class_name: 'PokemonType'


end
