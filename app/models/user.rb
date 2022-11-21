class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

	has_many :payments, :dependent => :destroy # Cada usuario posee un historial de pagos
	has_many :rents, :dependent => :destroy #Cada usuario tiene multiples alquileres
	has_one_attached :file

  	enum genero: [:Femenino, :Masculino]
	enum :rango, [:Admin, :Supervisor, :Usuario, :No_Aceptado, :A_Verificar, :Baneado], default: :A_Verificar #Los rangos de el usuario

	validates :email, presence: true, uniqueness: true #se fija si esta puesto y si es unico en el formulario/en la consola
	validates :dni, presence: true, uniqueness: true  
	validates :telephone, presence: true, numericality: true, uniqueness: true
	validates :birthdate, presence: true
	validate :en_edad
	validates_format_of :dni,:with => /\A([a-zA-Z]{0,3}[0-9]{6,9})?\z/, :message => "o numero de pasaporte incorrecto. Pon uno en formato adecuado."
	validates_format_of :email,:with => Devise::email_regexp #Se fija el formato de el email
	validate :documento_puesto
	

	private
	def en_edad
		if (!birthdate.nil?)
        	if (((Date.today.year - birthdate.year) < 21))  #Tuve que hacer 3 ifs sino no funciona el codigo, no se porque
           	 	errors.add(:base, "Debes ser mayor a 21.")
       		elsif (((Date.today.year - birthdate.year) == 21) && (Date.today.month < birthdate.month))
				errors.add(:base, "Debes ser mayor a 21.")
			elsif (((Date.today.year - birthdate.year) == 21) && (Date.today.month == birthdate.month) && (Date.today.day < birthdate.day))
				errors.add(:base, "Debes ser mayor a 21.")
			end
		end
    end

	def documento_puesto
		if(!file.attached?)
			errors.add(:base, "Documentos necesarios")
		end
	end

end
