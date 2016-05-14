class Article < ActiveRecord::Base
	include AASM #Para q el modelo pueda hacer uso de las funciones de la maquina de estado.

	belongs_to :user #asociaciones, Un articulo pertenece a un usuario
	has_many :comments

	has_many :has_categories#Tabla intermedia creada por la relacion de muchos a muchos.
	has_many :categories, through: :has_categories#through: Atravez de.


	validates :title, presence: true, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}
	before_save :set_visits_count#Codigo en comun
	after_create :save_categories
	after_create :send_mail
	

	has_attached_file :cover, styles: { medium: "1280x720", thumb:"420x420" }#El archivo adjunto q se va a subir
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/ #Por seguridad para evitar ataques, se descoge el formato de la img q se va a subir(VALIDACION)


	scope :publicados, ->{where(state: "published")} #Metodo de clase: Metodo q solo afecta a la clase no al objeto de este.
	scope :ultimos, ->{order("created_at DESC")} #Ordena los articulos por fecha de creacion los ultimos primero(Descendente).


	#Custom setter o atributo virtual
	def categories=(value)#setter: Es un metodo q permite asignarle valor al atributo de un objeto.
		@categories = value#Guarda en una variable el arreglo de categories.
	end

	def update_visits_count
		#self.save if self.visits_count.nil?#Si el contador de visitas es nil guardalo, esto activa before save
		self.update(visits_count: self.visits_count + 1)
	end


	aasm column: "state" do #state = La columna q va utilizar para controlar la maquina de estado.
	state :in_draft, initial: true #El estado inicial en q va estar el modelo es in_draft(en borrador).
	state :published

		event :publish do #Trancisiones entre los estados
			transitions from: :in_draft, to: :published #Pasa de draft a publicado
		end
		event :unpublish do
			transitions from: :published, to: :in_draft #Pasa de publicado a in_draft.
		end
	end


	private

	def send_mail
		ArticleMailer.new_article(self).deliver_later #deliver_latter: Permite ejecutar codigo asincrono.
	end
	def save_categories
		unless @categories.nil?#No hagas esto en caso de q esta condicion sea verdadero, a menos de q categorias sea nil haz esto
			@categories.each do |category_id|
				HasCategory.create(category_id: category_id, article_id: self.id)#self hace referencia al objeto con q se esta trabajo, este caso article.
			end
		end
	end

	def set_visits_count
		self.visits_count ||= 0 #Si es nil asignale este valor si no dejalo como esta
	end
end
