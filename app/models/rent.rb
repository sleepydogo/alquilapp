class Rent < ApplicationRecord
	
	belongs_to :user
	belongs_to :car

	accepts_nested_attributes_for :car
	validates :tiempo, presence: true

	validate :con_saldo, on: :create
	validate :sin_cooldown, on: :create
  validate :no_mas_de_24, on: :update
  #validate :no_antes, on: :update

	def con_saldo
        if (user.saldo < precio)
            errors.add(:precio, "No tiene el saldo suficiente.")
        end
    end

	def sin_cooldown
		tiempobuffer= DateTime.now
		tiempobuffer= tiempobuffer.change(hour: (tiempobuffer.hour-3), min: tiempobuffer.minute)
		if !(Rent.where(user_id: user.id).where(car_id: car.id).where("tiempo > ?", tiempobuffer).empty?)
			errors.add(:tiempo, "No puede volver a alquilar este auto por cooldown")
		end
	end
  
  def no_mas_de_24
    tiempobuffer = created_at.change(day: (created_at.day+1))
    if (tiempo > tiempobuffer)
      errors.add(:tiempo, "No se puede alquilar mas de 24 horas")
    end
  end
  
  #def no_antes
  #  if (tiempo < tiempo_original)
  #    errors.add(:tiempo, "Selecciona una hora posterior a tu pedido original")
  #  end
  #end

end
