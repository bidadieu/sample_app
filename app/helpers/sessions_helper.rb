module SessionsHelper

  def sign_in(user)
    # puts a cookie in user's browser; user.id signed with salt
    # keeps a user permanently-ish logged in
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  # used to authenticate access to pages -- 
  # see users_controller.authenticate and before_filter
  def deny_access
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path unless signed_in?
  end

  private
  
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end

end
