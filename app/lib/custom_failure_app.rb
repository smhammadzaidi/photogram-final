class CustomFailureApp < Devise::FailureApp
  def redirect_url
    if warden_message == :timeout
      flash[:alert] = I18n.t('devise.failure.timeout')
    elsif warden_message == :unauthenticated
      flash[:notice] = "Signed out successfully."
    end
    super
  end
end 
