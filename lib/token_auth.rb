module TokenAuth
  module User
    extend ActiveSupport::Concern
  
    included do
      # You likely have this before callback set up for the token.
      before_save :ensure_authentication_token
    end

    def ensure_authentication_token
      if authentication_token.blank?
        self.authentication_token = generate_authentication_token
      end
    end

    private
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless self.class.where(authentication_token: token).first
      end
    end

  end

  module Controller
    extend ActiveSupport::Concern
  
    included do
      # This is our new function that comes before Devise's one
      before_filter :authenticate_user_from_token!
    end

    private
      def authenticate_user_from_token!
        user_email = params[:user_email].presence
        user       = user_email && ::User.find_by_email(user_email)

        # Notice how we use Devise.secure_compare to compare the token
        # in the database with the token given in the params, mitigating
        # timing attacks.
        if user && Devise.secure_compare(user.authentication_token, params[:user_token])
          sign_in user, store: false
          
          # This is Devise's authentication
          authenticate_user!
        end
      end

  end

  
end
