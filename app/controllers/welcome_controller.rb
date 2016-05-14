class WelcomeController < ApplicationController
	before_action :authenticate_admin!, only:[:dashboard] #Solo el admin puede publicar y destruir articulo los demas solo pueden subirlos a "in_draft".

  def index
  end

  def dashboard
		@articles = Article.all
	end
end
	