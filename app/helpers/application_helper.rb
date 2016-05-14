module ApplicationHelper
	#Muestra la imagen del articulo como portada en el show parte superior.
	def article_cover url, options = {} #url: es la url de la img. Options: es opcional por q ya esta inicializado como vacio en caso de no mandarle un dato
		html_class = options[:class]
		html_style = "background:url(#{url});"\
						"width:100%;height:400px;background-size: cover;"

		html = "<header style='#{html_style}' class='#{html_class}'>""</header>" # \: Permite continuar una cadena en la sguiente linea.
				
		html.html_safe
	end
	
end
