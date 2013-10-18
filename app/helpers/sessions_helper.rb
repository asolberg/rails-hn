module SessionsHelper

def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    !self.current_user.nil?
  end


  def signed_in_user
    unless signed_in?
      @sign_in_message = "Sorry! You must be signed in to do that."
      respond_to do |format|
        format.html {redirect_to signin_url, notice: @sign_in_message}
        format.json do
          flash[:notice] = @sign_in_message
          render json: {success: false, redirect: signin_path}
        end
      end 
  end
      
end

  
  

 def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

end
