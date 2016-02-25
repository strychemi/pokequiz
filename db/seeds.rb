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

MULTIPLIER = 10
TYPES = 2

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
    TypeRelationship.create(attack_type_id: attack, defend_type_id: defend, effectiveness: "normal" )
  end
end
