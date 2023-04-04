module ApiKeyAuthenticatable
    include ActionController::HttpAuthentication::Token::ControllerMethods
    
    extend ActiveSupport::Concern
    
    attr_reader :current_api_key
    attr_reader :current_bearer
    
    # Raises an error and automatically responds with a 401 HTTP status code
    # when API key authentication fails
    def authenticate_with_api_key!
      @current_bearer = authenticate_or_request_with_http_token { |token, options| authenticator(token) }
    end
    
    # Allows for optional API key authentication
    def authenticate_with_api_key
      @current_bearer = authenticate_with_http_token { |token, options| authenticator(token) }
    end
    
    private
    
    attr_writer :current_api_key
    attr_writer :current_bearer
    
    # Authenticates the API key token and returns the bearer if successful
    def authenticator(token)
      @current_api_key = ApiKey.find_by(token_digest: token)
    
      current_api_key&.bearer
    end
end
  