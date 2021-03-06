class SessionsController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.find_by(email: params[:user][:email])
		if @user.nil?
			redirect_to users_sign_in_path, alert: 'El usuario no existe'
			return
		end

		if @user.password == params[:user][:password]
			session[:user_id] = @user.id
			redirect_to root_path
		else
			redirect_to users_sign_in_path, alert: 'El password no es valido'
		end
	end

	def destroy
		reset_session #Para asegurarnos de borrar todos los valores (Carro de compra por ejemplo)
		redirect_to root_path
	end

	private
	def session_params
		params.require(:user).permit(:email, :password)
	end
end
