require 'net/http'
require 'uri'
require 'json'
require 'base64'
require 'securerandom'

class Api::V1::AuthorizeController < ApplicationController
  def get_apiuser    
    reference_id = SecureRandom.uuid

    uri = URI('https://sandbox.momodeveloper.mtn.com/v1_0/apiuser')

    headers = {
      'X-Reference-Id' => reference_id,
      'Content-Type' => 'application/json',
      'Ocp-Apim-Subscription-Key' => '87d8a64e6db44d65ba0b86024ce5b7f6'
    }

    data = {
      'providerCallbackHost' => 'tunespot.biz'
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = data.to_json

    http.request(request)
    reference_id
  end

  def create_api_key(reference_id)
    uri = URI("https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/#{reference_id}/apikey")
  
    headers = {
      'Content-Type' => 'application/json',
      'Ocp-Apim-Subscription-Key' => '87d8a64e6db44d65ba0b86024ce5b7f6'
    }
  
    data = {
      'providerCallbackHost' => 'tunespot.biz'
    }
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = data.to_json
  
    response = http.request(request)
  
    {
        api_key: JSON.parse(response.body)['apiKey'],
        api_user: reference_id
    }
  end

  def create_access_token(api_user_id, api_key)
    uri = URI('https://sandbox.momodeveloper.mtn.com/collection/token/')
  
    headers = {
      'Authorization' => "Basic #{Base64.encode64("#{api_user_id}:#{api_key}").gsub("\n", "")}",
      'Ocp-Apim-Subscription-Key' => 'f1bc2773ffec4fdbb98720b4e227884d',
      'Content-Type' => 'application/json'
    }
  
    data = {
      'grant_type' => 'client_credentials'
    }
  
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = data.to_json
  
    response = http.request(request)
  
    if response.code.to_i == 200
      JSON.parse(response.body)['access_token']
    else
      nil
    end
  end

  def request_to_pay(token)
    reference_id = SecureRandom.uuid.to_s
    uri = URI('https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay')

    request = Net::HTTP::Post.new(uri)

    request['Authorization'] =  "Bearer #{token}"
    # request['X-Callback-Url'] = "tunespot.biz"
    request['X-Reference-Id'] = reference_id
    request['X-Target-Environment'] = "sandbox"
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = "f1bc2773ffec4fdbb98720b4e227884d"

    request.body = {
        "amount" => "5000",
        "currency" => "EUR",
        "externalId" => "12345",
        "payer" => {
          "partyIdType" => "MSISDN",
          "partyId" => "0780123456"
        },
        "payerMessage" => "test message",
        "payeeNote" => "test note"
      }.to_json
      
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
      
    puts response.code
    puts response.message
    reference_id
  end

  def request_to_pay_status(token, reference_id)
    uri = URI("https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay/#{reference_id}")

    request = Net::HTTP::Get.new(uri)
    request['Authorization'] =  "Bearer #{token}"
    request['X-Reference-Id'] = reference_id
    request['X-Target-Environment'] = "sandbox"
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = "f1bc2773ffec4fdbb98720b4e227884d"
    request.body = '{body}'

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    response.body
  end

  def get_token
    api_user_response = get_apiuser
    api_key_response = create_api_key(api_user_response)
    token = create_access_token(api_key_response[:api_user], api_key_response[:api_key])
    reference_id = request_to_pay(token)
    payment_status = request_to_pay_status(token, reference_id)
    render json: payment_status
  end
end
