class ApplicationMailer < ActionMailer::Base
  default from: "info@codigofacilito.com" #De donde van a salir los correos, correo emisor.
  layout nil #Codigo q va a mostrar todos los correos, ejem: una firma o una dirrecion a una pagina.
end
