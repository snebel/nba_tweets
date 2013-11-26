class SessionsController < ApplicationController
def create
  auth = request.env["omniauth.auth"]
  user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  redirect_to root_url, :notice => "Signed in!"
end

  def new
    redirect_to '/auth/twitter'
  end

def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => "Signed out!"
end

  def show
  	if session['access_token'] && session['access_secret']
      @user = client.user
    else
      redirect_to failure_path
    end
  end

  def error
    flash[:error] = "Sign in with Twitter failed"
    redirect_to root_path
  end
end
