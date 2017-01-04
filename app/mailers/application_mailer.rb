class ApplicationMailer < ActionMailer::Base
  default from: "admin@blocipedia.com"

  def sign_up_confirmation(user)
    @user = user
    mail(to: user.email, subject: "Sign Up Confirmation for Blocipedia")
  end

  def password_reset(user)
    @user = user
    mail(to: user.email, subject: "Blocipedia - Password Reset")
  end
end
