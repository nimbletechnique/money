class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://money.gluedtomyseat.com/activate/#{user.activation_code}"
  
  end
  
  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://money.gluedtomyseat.com/"
  end
  
  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "Glued To My Money <do-not-reply@gluedtomyseat.com>"
      @subject     = " "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
