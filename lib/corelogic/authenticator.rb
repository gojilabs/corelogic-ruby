# frozen_string_literal: true

require 'dry-initializer'
require 'corelogic/response_parser'
require 'net/http'

module Corelogic
  class Authenticator
    extend Dry::Initializer

    OAUTH_URL = 'https://api-prod.corelogic.com/oauth/token'

    option :consumer_key
    option :consumer_secret

    def call(connection, options = {})
      options = options.dup
      options[:grant_type] ||= 'client_credentials'
      force = options.delete(:force) || false
      return connection if !force && connection.authenticated?

      uri = URI(OAUTH_URL)
      uri.query = URI.encode_www_form(options)
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(credentials[:user], credentials[:pass])

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true

      response = http.start do |client|
        client.request(request)
      end

      token = Corelogic::ResponseParser.perform(response)[:access_token]
      connection.bearer_token = token
      connection
    end

    private

    def credentials
      {
        user: consumer_key,
        pass: consumer_secret
      }
    end
  end
end
