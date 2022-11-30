class Ticket < ApplicationRecord
    belongs_to :user
	belongs_to :car
    has_many_attached :photo
    has_many :mensaje
    accepts_nested_attributes_for :car

end
