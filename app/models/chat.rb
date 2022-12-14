class Chat < ApplicationRecord
  belongs_to :application

  has_many :messages, dependent: :destroy

  validates :number,
  numericality: {only_integer: true, greater_than_or_equal_to: 1},
  uniqueness:{scope: :application_id}

end