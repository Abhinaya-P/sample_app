class SessionsController < ApplicationController

	def new
	end


	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password]) 	
			flash.now[:success] = "You have logged in successfully"
			sign_in(user)
			redirect_to user_path(user)
		else
			flash.now[:failure] = "Invalid Username or password"
			render 'new'
		end
	end


	def destroy
		sign_out
		redirect_to root_path
	end
end
