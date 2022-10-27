class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  	enum genero: [:Femenino, :Masculino]
	enum :rango, [:Admin, :Supervisor, :Usuario, :No_Aceptado, :A_Verificar], default: :A_Verificar
	
	#after_initialize do
    #	if self.new_record?
    #	  self.rango ||= :A_Verificar
    #	end
  	#end
	
	validates :email, presence: true, uniqueness: true #se fija si esta puesto y si es unico en el formulario/en la consola
	validates :dni, presence: true, uniqueness: true
	validates :telephone, presence: true
end
