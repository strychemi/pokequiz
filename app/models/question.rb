class Question < ActiveRecord::Base
  include AnswerStats

  belongs_to :category
  has_many :results

  validates :solution, :question, :category, :frequency, presence: true
  validates :question, uniqueness: { scope: :solution, message: "This question/solution set already exists in the database!"}

  def get_choices
    [self.solution, self.option_1, self.option_2, self.option_3].shuffle
  end

  def self.make_photo_question
    random_question = "What is this pokemon?"
    solution = Pokemon.all.sample.name
    question = Question.find_by(question: random_question, solution: solution)

    if question
      return question
    else
      photo_category = Category.find_by_name('photo')
      question = Question.new(question: random_question, solution: solution, category_id: photo_category.id, frequency: 0)
      choice = generate_wrong_choices("Pokemon", solution)
      question.option_1 = choice[0]
      question.option_2 = choice[1]
      question.option_3 = choice[2]
      question.save!
      question
    end
  end

  def self.generate_wrong_choices(resource, solution)
    choices = []
    # generates answer choices
    until choices.size == 3
      wrong_choice = resource.constantize.all.sample.name
      choices << wrong_choice if (solution != wrong_choice && !choices.include?(wrong_choice))
    end
    choices
  end

  def self.make_type_question
    current_pokemon = Pokemon.all.sample
    random_question = "What is #{current_pokemon.name}'s type? (There is only one correct answer)"
    solution = current_pokemon.first_type.name
    type_category = Category.find_by_name('type')
    question = Question.find_by(question: random_question, solution: solution)
    # front end make sure to pull image based on solution for this category of question
    if question
      return question
    else
      question = Question.new(question: random_question, solution: solution, category_id: type_category.id, frequency: 0)
    end
    # generates answer choices
    answer_choices = generate_wrong_types(current_pokemon, current_pokemon.first_type, solution)
    question.option_1 = answer_choices[0]
    question.option_2 = answer_choices[1]
    question.option_3 = answer_choices[2]
    question.save!
    question
  end

  def self.generate_wrong_types(pokemon, type, solution)
    choices = []
    # generates answer choices
    until choices.size == 3
      wrong_choice = PokemonType.all.sample
      wrong_type = wrong_choice.name
      choices << wrong_type if (solution != wrong_type && !choices.include?(wrong_type) && pokemon.first_type != wrong_choice && pokemon.second_type != wrong_choice)
    end
    choices
  end

  def correct_results
    Result.where(question: self).where(result: true)
  end

  def incorrect_results
    Result.where(question: self).where(result: false)
  end

  def poke_from_solution
    Pokemon.find_by_name(self.solution)
  end

  def poke_from_type_question
    poke_regex = /([\w]*)'/
    poke_name = self.question.match(poke_regex)[1]
    Pokemon.find_by_name(poke_name)
  end
end