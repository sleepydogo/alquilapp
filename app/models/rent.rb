class Rent < ApplicationRecord
	
	belongs_to :user
	belongs_to :car

	accepts_nested_attributes_for :car
	validates :tiempo, presence: true

	validate :con_saldo, on: :create
	validate :sin_cooldown, on: :create

	def con_saldo
        if (user.saldo < precio)
            errors.add(:precio, "No tiene el saldo suficiente.")
        end
    end

	def sin_cooldown
		tiempobuffer= DateTime.now
		tiempobuffer= tiempobuffer.change(hour: (tiempobuffer.hour+3), min: tiempobuffer.minute)
		if !(Rent.where(user_id: user.id).where("tiempo < ?", tiempobuffer).where(car_id: car.id).empty?)
			errors.add(:tiempo, "No puede volver a alquilar este auto por cooldown")
		end
	end

end
