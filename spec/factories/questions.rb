FactoryGirl.define do
  factory :question do
    question "This is a string"
    solution "solutiontext"
    category  
    frequency 1
    option_1 "one"
    option_2 "two"
    option_3 "three"
  end
end
