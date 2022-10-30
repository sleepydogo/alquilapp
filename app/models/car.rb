class Car < ApplicationRecord

	has_many :rents
	has_one_attached :photo
end
