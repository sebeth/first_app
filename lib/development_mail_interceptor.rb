class DevelopmentMailInterceptor

	def self.delivering_email(message)
		message.to="sebeth@gmail.com"
	end
end
