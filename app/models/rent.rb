class Rent < ApplicationRecord
	belongs_to :car
	belongs_to :victim
end
