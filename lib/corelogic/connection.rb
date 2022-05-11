# frozen_string_literal: true

module Corelogic
  class Connection
    attr_accessor :bearer_token

    def initialize(options = {})
      @bearer_token = options[:bearer_token]
    end

    BASE_PATH = 'https://property.corelogicapi.com/v2/properties/'

    def get(path, params = {})
      headers = { 'Authorization' => bearer_auth_header }

      uri = url(path)
      uri.query = URI.encode_www_form(params)
      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true
      http.set_debug_output $stdout if ENV['CORELOGIC_DEBUG'].present?

      http.get(uri, headers)
    end

    def authenticated?
      bearer_token.present?
    end

    private

    def bearer_auth_header
      "Bearer #{bearer_token}"
    end

    def url(path)
      URI.join(BASE_PATH, path)
    end
  end
end
