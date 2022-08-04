# frozen_string_literal: true

module Corelogic
  class Connection
    attr_accessor :bearer_token

    def initialize(options = {})
      @bearer_token = options[:bearer_token]
    end

    V2_BASE_PATH = 'https://property.corelogicapi.com/v2/'
    V1_BASE_PATH = 'https://api-prod.corelogic.com/'

    def get(path, api_version, params = {})
      headers = { 'Authorization' => bearer_auth_header }

      base_path =
        case api_version
        when :v1 then V1_BASE_PATH
        when :v2 then V2_BASE_PATH
        end

      uri = url(path, base_path)
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

    def url(path, base_path = V2_BASE_PATH)
      URI.join(base_path, path)
    end
  end
end
