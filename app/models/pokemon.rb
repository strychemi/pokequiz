class Pokemon < ActiveRecord::Base
  has_many :profiles
  belongs_to :type, foreign_key: :first_type_id
  belongs_to :second_type, class_name: "Type", foreign_key: :second_type_id

  def first_type
    Type.find(self.first_type_id)
  end

  def second_type
    second_type_id ? Type.find(self.second_type_id) : nil
  end

  def types
    # TODO: Possible refactor
    first_type + second_type
  end
end
