module PermissionsConcerns
	extend ActiveSupport::Concern #Para q sea un concern riene q ser un extende de activeSupport

	def is_normal_user? #Signo de insterrogacion representa q un metodo booleano.
		self.permission_level >= 1
	end

	def is_editor? #Signo de insterrogacion representa q un metodo booleano.
		self.permission_level >= 2
	end

	def is_admin? #Signo de insterrogacion representa q un metodo booleano.
		self.permission_level >= 3
	end
end