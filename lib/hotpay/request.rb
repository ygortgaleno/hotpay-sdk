require 'net/http'
require 'uri'
require 'json'

class Request
  def initialize(host)
    @host = host
  end

  def post_request(path = nil, body = nil, headers = {}, query = {})
    uri = build_uri(path, query)
    headers = headers.merge({ 'Content-Type': 'application/json' })

    request = Net::HTTP::Post.new(uri, headers)
    request.body = body.nil? ? body : body.to_hash
    
    start_request(uri, request)
  end

  def get_request(path = nil, headers = {}, query = {})
    uri = build_uri(path, query)
    headers = headers.merge({ 'Content-Type': 'application/json' })
    
    request = Net::HTTP::Get.new(uri, headers)
    
    start_request(uri, request)
  end

  private
  attr_accessor :host

  def build_uri(path, query)
    URI::HTTPS.build(host: @host, path: path, query: URI.encode_www_form(query))
  end

  def start_request(uri, request)
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    JSON.parse(response.body)
  end
end
