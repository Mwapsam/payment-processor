require 'rest-client'
require 'json'

module AirtelAPI
  def self.get_access_token
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => '*/*'
    }

    payload = {
      "client_id": "YOUR_CLIENT_ID",
      "client_secret": "YOUR_CLIENT_SECRET",
      "grant_type": "client_credentials"
    }

    response = RestClient.post('https://openapiuat.airtel.africa/auth/oauth2/token', payload.to_json, headers)

    access_token = JSON.parse(response)["access_token"]
    return access_token
  end
end
