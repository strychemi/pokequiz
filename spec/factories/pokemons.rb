FactoryGirl.define do
  factory :pokemon do
    name "pokemon"
    pokemon_type
   # association :pokemon_type, :factory => [:pokemon_type]
  end
end
