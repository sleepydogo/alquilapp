class Car < ApplicationRecord

	has_many :rents, :dependent => :destroy
	has_one_attached :photo
	has_one_attached :file
	acts_as_mappable
	

	validates :patente, presence: true, uniqueness: true
	validates :modelo, presence: true
	validates_format_of :patente,:with => /\A([a-zA-Z]{2,3}[0-9]{3}[a-zA-Z]{0,2})?\z/
end
