class ArticlesController < ApplicationController
	#before_action :validate_user, except: [:show,:index]#CALLBACKS. Si el usuario no esta conectado redirijalo a iniciar session, excepto para show y index
	before_action :authenticate_user!, except: [:index,:show]#CALLBACKS DEVISE. Si el usuario no esta conectado redirijalo a iniciar session, excepto para show y index
	before_action :set_article, except: [:index,:new,:create] #Permite hacer refactor del codigo
	
	before_action :authenticate_editor!, only: [:new,:create,:update]#El usuario editor solo podra crear y eliminar.
	before_action :authenticate_admin!, only: [:destroy,:publish] #El usuario admin  podra eliminar.

	#GET /articles
	def index
		@articles = Article.paginate(page: params[:page],per_page:10).publicados.ultimos #Muestra todos los articulos en estado published(publicado) y ordenados por fecha de creaciond descendente.
		#Muestra 5 articulos por pagina.
		#paginate: metodo para paginar propip de la gema gem "will_paginate".
	end

	#GET /articles/:id
	def show
		
		@article.update_visits_count
		@comment = Comment.new #inicializacion de un nuevo comentario
	end

	#GET /articles/new
	def new
		@article = Article.new
		@categories = Category.all#Permite tener acceso a las categorias atraves del formulario de articles.
	end

	def edit
		
	end

	#POST /articles
	def create
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]#Se le asigna los valores del arreglo de categories(categories[]) en el formulario de articles
		if @article.save #CONDICION DE LA VALIDACION DEL MODELO ARTICLE.
			redirect_to @article
		else
			render :new
		end
	end 

	#PUT /articles/:id
	def update
		if @article.update(article_params)
			redirect_to articles_path
		else
			render :edit
		end
	end

	#DELETE /articles/:idarticle_params
	def destroy
		
		@article.destroy
		redirect_to @article
	end
	
	def publish
		@article.publish! #Metodo q se utilizo en la consola para publicar
		redirect_to dashboard_path
	end
	

	private	
	
	def set_article
		@article = Article.find(params[:id])#Codigo en comun
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover,:categories, :markup_body)
	end



end#FINAL


