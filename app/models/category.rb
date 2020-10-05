class Category < ApplicationRecord
  validates :name, presence: true
  
  # The both statments has the same behaviour
  # validates :name, uniqueness: true
  validates_uniqueness_of :name

  # The both statments has the same behaviour
  # validates :name, length: { in: 3..25 }
  validates :name, length: { minimum: 3, maximum:25 }
end