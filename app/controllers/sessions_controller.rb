class SessionsController < ApplicationController
  def new
    
  end
  def create
    user = Usuario.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logado!"
    else
      flash.now[:alert] = "Email ou senha incorretos"
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "Deslogado!"
  end
end
