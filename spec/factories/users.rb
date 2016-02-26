FactoryGirl.define do
  factory :user, aliases: [:followed, :follower] do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    profile
  end
end
