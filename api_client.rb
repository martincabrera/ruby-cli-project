# frozen_string_literal: true

require 'net/http'
require 'json'


class ApiClient

  ENDPOINT = 'https://api.magicthegathering.io'
  VERSION = '/v1'

  HTTP_VERBS = {
      get: Net::HTTP::Get,
      head: Net::HTTP::Head,
  }

  attr_reader :http

  def initialize(endpoint = ENDPOINT)
    uri = URI.parse(endpoint)
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
  end

  def self.get(path, params = {})
    self.new.get(path, params)
  rescue StandardError => error
    raise error
  end

  def self.head(path, params = {})
    self.new.head(path, params)
  rescue StandardError => error
    raise error
  end

  def get(path, params)
    request_json(path, params)
  end

  def head(path, params)
    request(:head, path, params)
  end

  def full_path(path, params)
    absolute_path = [VERSION, path].join("/")
    return absolute_path if params.empty?
    [absolute_path, URI.encode_www_form(params)].join("?")
  end

  private


  def request_json(path, params)
    response = request(:get, path, params)
    JSON.parse(response.body)
  end

  def request(method, path, params)
    path = full_path(path, params)
    request = HTTP_VERBS[method].new(path)
    http.request(request)
  end


end
