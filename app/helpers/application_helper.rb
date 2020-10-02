module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    #
    # Source: https://en.gravatar.com/site/implement/images/ruby/
    #

    # get the email from URL-parameters or what have you and make lowercase
    email_address = user.email.downcase
 
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email_address)
    
    size = options[:size]

    # compile URL which can be used in <img src="RIGHT_HERE"...
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(image_src, alt: user.username, class: "shadow rounded mx-auto d-block")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #
    # Double Bang converts "something" to boolean
    #
    !!current_user
    #!session[:user_id].nil?
  end
end
