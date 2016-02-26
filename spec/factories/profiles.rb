FactoryGirl.define do
  factory :profile do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name) { |n| "Last#{n}" }
    sequence(:username) { |n| "firstlast#{n}"}
    sequence(:user_id) { |n| n }
    pokemon_id(1)
    type_id(1)
  end
end
