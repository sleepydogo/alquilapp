class User < ApplicationRecord
	has_secure_password #para la encriptacion de la contra
	
	enum status: [:administrador, :moderador, :usuario, :no_aceptado, :a_aceptar]
	enum genero: [:Femenino, :Masculino]
	
	validates :mail, presence: true, uniqueness: true #se fija si esta puesto y si es unico en el formulario/en la consola
	validates :dni, presence: true, uniqueness: true
	validates :telefono, presence: true

	has_many :rents
end
