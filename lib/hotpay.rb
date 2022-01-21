require "hotpay/version"
require "hotpay/auth.rb"
require "hotpay/sales.rb"

module Hotpay
  class Error < StandardError; end
  class << self
    attr_accessor :client_id, :client_secret, :basic_token
    attr_writer :sandbox

    def config
      yield self

      get_errors
    end

    def sandbox
      @sandbox == true
    end

    private
    
    def get_errors
      errors = []

      unless self.client_id.instance_of? String
        errors.push("The client_id must be a string, #{self.client_id.class} given")
      end

      unless self.client_secret.instance_of? String
        errors.push("The client_secret must be a string, #{self.client_secret.class} given")
      end

      unless self.basic_token.instance_of? String
        errors.push( "The basic_token must be a string, #{self.basic_token.class} given")
      end

      unless errors.empty?
        raise Error.new errors.join('. ')
      end
    end
  end
end
