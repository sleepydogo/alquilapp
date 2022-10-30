class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :rents #Cada usuario tiene multiples alquileres
	has_one_attached :file

  	enum genero: [:Femenino, :Masculino]
	enum :rango, [:Admin, :Supervisor, :Usuario, :No_Aceptado, :A_Verificar, :Baneado], default: :A_Verificar #Los rangos de el usuario
	
	validates :email, presence: true, uniqueness: true #se fija si esta puesto y si es unico en el formulario/en la consola
	validates :dni, presence: true, uniqueness: true
	validates :telephone, presence: true, numericality: true
	validate :en_edad
	validates_format_of :email,:with => Devise::email_regexp #Se fija el formato de el email

	def en_edad
        if (((Date.today.year - birthdate.year) <21) && (Date.today.month < birthdate.month) && (Date.today.day < birthdate.day))
            errors.add(:birthdate, "Debes ser mayor a 21.")
        end
    end
end
