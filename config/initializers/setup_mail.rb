require 'development_mail_interceptor'
ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => '587',
	:domain => 'gmail.com',
	:user_name => 'sebeth@gmail.com',
	:password => 'soniagrey230223',
	:authentication => :login,
	:enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host]="localhost:3000"
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?