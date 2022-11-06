class Rent < ApplicationRecord
	
	belongs_to :user
	belongs_to :car

	accepts_nested_attributes_for :car

end
