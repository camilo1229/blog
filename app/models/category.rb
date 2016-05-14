class Category < ActiveRecord::Base
	validates :name, presence: true
	has_many :has_categories#Tabla intermedia creada por la relacion de muchos a muchos.
	has_many :articles, through: :has_categories#through: Atravez de.

end
