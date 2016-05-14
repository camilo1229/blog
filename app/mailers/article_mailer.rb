class ArticleMailer < ApplicationMailer

	def new_article(article) #Se envia un correo a todos los usuarios cuando se cree un articulo
		@article = article

		User.all.each do |user|
			mail(to: user.email, subject: "Nuevo articulo en BlogFacilito") #Se le envia un email  a todos los usuarios de la app.
		end
	end	

end
