require_relative 'request.rb'

module Hotpay
  class Auth < Request
    def initialize
      host = 'api-sec-vlc.hotmart.com'
      super(host)

      @path = '/security/oauth/token'
    end

    def authenticate
      headers = {
        'Authorization': Hotpay.basic_token
      }
      query = {
        grant_type: 'client_credentials',
        client_id: Hotpay.client_id,
        client_secret: Hotpay.client_secret
      }

      response = post_request(@path, nil, headers, query)
  
      response.to_hash
    end

    private
    attr_accessor :path
  end
end