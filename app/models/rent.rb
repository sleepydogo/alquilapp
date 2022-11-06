class Rent < ApplicationRecord
	
	belongs_to :user
	belongs_to :car

	accepts_nested_attributes_for :car

	validate :con_saldo, on: :create
	validate :sin_cooldown, on: :create

	def con_saldo
        if (user.saldo < precio)
            errors.add(:precio, "No te alcanza el saldo.")
        end
    end

	def sin_cooldown
		tiempobuffer= DateTime.now
		tiempobuffer= tiempobuffer.change(hour: (tiempobuffer.hour+3), min: tiempobuffer.minute)
		if !(Rent.where(user_id: user.id).where("tiempo < ?", tiempobuffer).empty?)
			errors.add(:tiempo, "Tenes cooldown.")
		end
	end

end
