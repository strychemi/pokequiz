class Pokemon < ActiveRecord::Base
  has_many :profiles
  belongs_to :type

  def first_type
    Type.find(first_type_id)
  end

  def second_type
    second_type_id ? Type.find(second_type_id) : nil
  end

  def types
    # TODO: Possible refactor
    first_type + second_type
  end
end
