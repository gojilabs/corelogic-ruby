# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class Property
    extend Dry::Initializer

    option :clip, as: :clip
    option :v1PropertyId, as: :v1_property_id, optional: true
    option :propertyAddress, as: :property_address do
      option :streetAddress, as: :street_address
      option :propertyStreetAddressParsed, as: :property_street_address_parsed do
        option :houseNumber, as: :house_number
        option :streetNamePrefixDir, as: :street_name_prefix_dir
        option :streetName, as: :street_name
        option :streetNameSuffix, as: :street_name_suffix
        option :streetNameSuffixDir, as: :street_name_suffix_dir
        option :unitType, as: :unit_type
        option :unitNumber, as: :unit_number
      end
      option :city
      option :state
      option :zipCode, as: :zip_code
      option :zipPlus4, as: :zip_plus4
      option :county
    end
    option :propertyAPN, as: :property_apn do
      option :fipsCode, as: :fips_code
      option :apnSequenceNumber, as: :apn_sequence_number
      option :apnParcelNumberUnformatted, as: :apn_parcel_number_unformatted
      option :apnParcelNumberFormatted, as: :apn_parcel_number_formatted
      option :previousApnUnformatted, as: :previous_apn_unformatted
      option :universalParcelId, as: :universal_parcel_id
    end

    attr_writer :clip, :ownership, :building, :tax_assessment, :site_location, :ownership_transfers

    def self.search(options)
      Corelogic.properties.search(options)
    end

    def ownership
      @ownership ||= Corelogic.properties.ownership(clip)
    end

    def building
      @building ||= Corelogic.properties.building(clip)
    end

    def tax_assessment
      @tax_assessment ||= Corelogic.properties.tax_assessment(clip)
    end

    def site_location
      @site_location ||= Corelogic.properties.site(clip)
    end

    def ownership_transfers
      @ownership_transfers ||= Corelogic.properties.ownership_transfers(clip)
    end

    def load_details
      Corelogic.properties.property_detail(self)
    end
  end
end
