# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ----------------------------------------
# Database Reset
# ----------------------------------------

if Rails.env == 'development'
  puts 'Reseting database'

  Rake::Task['db:migrate:reset'].invoke
end

# ----------------------------------------
# Seed Config Vars
# ----------------------------------------

TYPES = 18
POKEMON = 10
MULTIPLIER = 10

# ----------------------------------------
# Setup API
# ----------------------------------------

@pokeapi = PokeAPI.new

# ----------------------------------------
# Make API calls for Type
# ----------------------------------------

puts "Making Type API calls"

@pokeapi.get_all_types

# ----------------------------------------
# Populate database with Types
# ----------------------------------------

puts "Populating database with types"

all_types = @pokeapi.types

(1..TYPES).each do |x|
  Type.create(name: all_types[x][:name] )
end

# ----------------------------------------
# Populate database with Type relationships
# ----------------------------------------

puts "Populating type_relationships with default normal effectiveness"
(1..TYPES).each do |attack|
  (1..TYPES).each do |defend|
    relation_checker = false
    relations_hash = all_types[attack][:damage_relations]

    if relations_hash['no_damage_to'][0]
      if relations_hash['no_damage_to'].any? { |relation| relation["name"] == all_types[defend][:name] }
        TypeRelationship.create(attack_type_id: attack, defend_type_id: defend, effectiveness: "no_damage" )
        relation_checker = true
      end
    end

    if relations_hash['half_damage_to'][0]

      if relations_hash['half_damage_to'].any? { |relation| relation["name"] == all_types[defend][:name] }
        TypeRelationship.create(attack_type_id: attack, defend_type_id: defend, effectiveness: "half_damage" )
        relation_checker = true
      end
    end

    if relations_hash['double_damage_to'][0]
      if relations_hash['double_damage_to'].any? { |relation| relation["name"] == all_types[defend][:name] }
        TypeRelationship.create(attack_type_id: attack, defend_type_id: defend, effectiveness: "double_damage" )
        relation_checker = true
      end
    end
    TypeRelationship.create(attack_type_id: attack, defend_type_id: defend, effectiveness: "normal" ) if relation_checker == false

  end
end

# ----------------------------------------
# Populate database with Pokemon
# ----------------------------------------

(1..POKEMON).to_a.each do |x|
  puts "Getting Pokemon #{x}"
  @pokeapi.get_pokemon(x.to_s)
  pokemon = @pokeapi.pokemon_complete
  p = Pokemon.new(name: pokemon[:name], first_type_id: Type.find_by_name(pokemon[:types][0]).id)
  p.second_type_id = Type.find_by_name(pokemon[:types][1]).id if pokemon[:types][1]
  p.save!
end

# ----------------------------------------
# Populate database with users, profiles
# ----------------------------------------

# MULTIPLIER.times do
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   username = Faker::Company.name
#
#   u = User.new
#   u.email = Faker::Internet.free_email("#{first_name} #{last_name}")
#   u.password = "qwerqwer"
#   u.save
#
#   up = Profile.new
#   up.user_id = u.id
#   up.first_name = first_name
#   up.last_name = last_name
#   up.username = username
#   up.save
# end
