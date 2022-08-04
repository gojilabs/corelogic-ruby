# frozen_string_literal: true

require 'logger'
require 'corelogic/response_parser'
require 'corelogic/building'
require 'corelogic/collection'
require 'corelogic/property'
require 'corelogic/property_detail'
require 'corelogic/ownership'
require 'corelogic/ownership_transfer'
require 'corelogic/rental_amount_model'
require 'corelogic/site_location'
require 'corelogic/tax_assessment'
require 'corelogic/automated_value_model'

module Corelogic
  class API
    include Corelogic::AutoInject['connection']
    include Corelogic::AutoInject['response_parser']
    include Corelogic::AutoInject['authenticator']

    SEARCH_PATH = 'properties/search'

    def search(options = {})
      Corelogic::Collection.new(Corelogic::Property, **perform_response(SEARCH_PATH, :v2, options))
    end

    def ownership(clip)
      Corelogic::Ownership.new(**perform_response("properties/#{clip}/ownership", :v2)[:data])
    end

    def building(clip)
      Corelogic::Building.new(**perform_response("properties/#{clip}/buildings", :v2)[:data])
    end

    def tax_assessment(clip)
      Corelogic::Collection.new(Corelogic::TaxAssessment, **perform_response("properties/#{clip}/tax-assessments/latest", :v2))
    end

    def site_location(clip)
      Corelogic::SiteLocation.new(**perform_response("properties/#{clip}/site-location", :v2)[:data])
    end

    def ownership_transfers(clip, sale_type = 'market', latest = 'latest')
      Corelogic::Collection.new(Corelogic::OwnershipTransfer, **perform_response("properties/#{clip}/ownership-transfers/#{sale_type}/#{latest}", :v2))
    end

    def property_detail(property)
      response = perform_response("properties/#{property.clip}/property-detail", :v2)

      property.building = Corelogic::Building.new(**response[:buildings][:data]) if response[:buildings]
      property.ownership = Corelogic::Ownership.new(**response[:ownership][:data]) if response[:ownership]
      property.ownership_transfers = Corelogic::Collection.new(Corelogic::OwnershipTransfer, **response[:mostRecentOwnerTransfer]) if response[:mostRecentOwnerTransfer]
      property.site_location = Corelogic::SiteLocation.new(**response[:siteLocation][:data]) if response[:siteLocation]
      property.tax_assessment = Corelogic::Collection.new(Corelogic::TaxAssessment, **response[:taxAssessment]) if response[:taxAssessment]
      property
    end

    def rental_amount_model(clip)
      Corelogic::RentalAmountModel.new(**perform_response('avms/ram', :v2, clip: clip))
    end

    def automated_value_model(clip, model)
      Corelogic::AutomatedValueModel.new(**perform_response("property/#{clip}/avm/thv/#{model}", :v1))
    end

    private

    def perform_response(path, api_version, options = {})
      try = 0
      begin
        try += 1
        response_parser.perform(perform_get(path, api_version, options))
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

    def perform_get(path, api_version, options = {})
      perform_connection.get(path, api_version, options)
    end

    def perform_connection(force: false)
      return authenticator.call(connection, force: true) if force
      return connection if connection.authenticated?

      authenticator.call(connection)
    end
  end
end
