require "sinatra"

require_relative "ldap"

get "/" do
	erb :content
end

post "/authenticate" do
	user = User.authenticate(params[:email], params[:password])

	if user
		session[:current_user_mail] = params[:email]
	end

	redirect to "/"
end

get "/hook" do

end
