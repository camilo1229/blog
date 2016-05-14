class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_categories

  protected
  #Hace validaciones como las de concern pero a nivel de controladores(Si el usuario esta logeado y tiene los permisos adecuados).
  #Permite ejecutar la validacion de los permisos en un callback en articles_controller.
 	def authenticate_editor!
		redirect_to root_path unless user_signed_in? && current_user.is_editor?#Redirijame al home a menos(unless) de q el usuario este logeado y ademas(currenst_user) se un editor.
	end

	def authenticate_admin! 
		redirect_to root_path unless user_signed_in? && current_user.is_admin?
	end


  private

  def set_categories
  	@categories = Category.all
  end
  
end
