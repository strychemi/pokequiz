class Category < ActiveRecord::Base
  has_many :questions

  validates :name, presence: true
  validates :category, uniqueness: :true
end
