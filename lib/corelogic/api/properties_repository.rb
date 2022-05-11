# frozen_string_literal: true

require 'logger'
require 'corelogic/response_parser'
require 'corelogic/building'
require 'corelogic/collection'
require 'corelogic/property'
require 'corelogic/property_detail'
require 'corelogic/ownership'
require 'corelogic/ownership_transfer'
require 'corelogic/site_location'
require 'corelogic/tax_assessment'

module Corelogic
  module API
    class PropertiesRepository
      include Corelogic::AutoInject['connection']
      include Corelogic::AutoInject['response_parser']
      include Corelogic::AutoInject['authenticator']

      SEARCH_PATH = 'search'

      def search(options = {})
        Corelogic::Collection.new(Corelogic::Property, **perform_response(SEARCH_PATH, options))
      end

      def ownership(clip)
        Corelogic::Ownership.new(**perform_response("#{clip}/ownership")[:data])
      end

      def building(clip)
        Corelogic::Building.new(**perform_response("#{clip}/buildings")[:data])
      end

      def tax_assessment(clip)
        Corelogic::Collection.new(Corelogic::TaxAssessment, **perform_response("#{clip}/tax-assessments/latest"))
      end

      def site_location(clip)
        Corelogic::SiteLocation.new(**perform_response("#{clip}/site-location")[:data])
      end

      def ownership_transfers(clip, sale_type = 'market', latest = 'latest')
        Corelogic::Collection.new(Corelogic::OwnershipTransfer, **perform_response("#{clip}/ownership-transfers/#{sale_type}/#{latest}"))
      end

      def property_detail(property)
        response = perform_response("#{property.clip}/property-detail")

        property.building = Corelogic::Building.new(**response[:buildings][:data]) if response[:buildings]
        property.ownership = Corelogic::Ownership.new(**response[:ownership][:data]) if response[:ownership]
        property.ownership_transfers = Corelogic::Collection.new(Corelogic::OwnershipTransfer, **response[:mostRecentOwnerTransfer]) if response[:mostRecentOwnerTransfer]
        property.site_location = Corelogic::SiteLocation.new(**response[:siteLocation][:data]) if response[:siteLocation]
        property.tax_assessment = Corelogic::Collection.new(Corelogic::TaxAssessment, **response[:taxAssessment]) if response[:taxAssessment]
        property
      end

      private

      def perform_response(path, options = {})
        try = 0
        begin
          try += 1
          response_parser.perform(perform_get(path, options))
        rescue Corelogic::Error::Unauthorized => e
          logger = Logger.new($stdout)
          logger.debug e.message
          if try < 2
            logger.debug { "Retry: #{try}" } if ENV.fetch('RAILS_ENV', nil) && ENV.fetch('RAILS_ENV', nil) == 'development'
            perform_connection(force: true)
            retry
          end
        end
      end

      def perform_get(path, options = {})
        perform_connection.get(path, options)
      end

      def perform_connection(force: false)
        return authenticator.call(connection, force: true) if force
        return connection if connection.authenticated?

        authenticator.call(connection)
      end
    end
  end
end
