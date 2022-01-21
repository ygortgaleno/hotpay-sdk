require_relative 'request.rb'

module Hotpay
  class Sales < Request
    def initialize
      host = "#{get_contextext}.hotmart.com"
      super(host)

      @path = '/payments/api/v1/sales/users'
    end

    def participants(access_token, query = {})
      headers = {
        'Authorization': "Bearer #{access_token}"
      }

      response = get_request(@path, headers, query)
  
      response.to_hash
    end

    private

    def get_contextext
      Hotpay.sandbox ? 'sandbox' : 'developers'
    end
  end
end