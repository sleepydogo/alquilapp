class Ticket < ApplicationRecord
    belongs_to :user
	belongs_to :car
    has_many_attached :photos
end
