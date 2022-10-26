class User < ApplicationRecord
	has_secure_password #para la encriptacion de la contra
	
	validates :mail, presence: true, uniqueness: true #se fija si esta puesto y si es unico en el formulario/en la consola
	validates :dni, presence: true, uniqueness: true
	validates :telefono, presence: true
end
