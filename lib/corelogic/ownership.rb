# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class Ownership
    extend Dry::Initializer

    option :clip
    option :currentOwners, as: :current_owners do
      option :ownerNames, [], as: :owner_names do
        option :sequenceNumber, proc(&:to_i), as: :sequence_number
        option :fullName, as: :full_name
        option :firstNameAndMiddleInitial, as: :first_name_and_middle_initial
        option :lastName, as: :last_name
        option :isCorporate, as: :is_corporate
      end
      option :relationshipTypeCode, as: :relationship_type_code
      option :ownerEtalCode, as: :owner_etal_code
      option :occupancyCode, as: :occupancy_code
      option :ownershipRightsCode, as: :ownership_rights_code
    end
    option :currentOwnerMailingInfo, as: :current_owner_mailing_info do
      option :mailingAddress, as: :mailing_address do
        option :careOfName, as: :care_of_name
        option :streetAddress, as: :street_address
        option :streetAddressParsed, as: :street_address_parsed do
          option :houseNumber, as: :house_number
          option :houseNumberSuffix, as: :house_number_suffix
          option :houseNumber2, as: :house_number2
          option :direction, as: :direction
          option :streetName, as: :street_name
          option :mailingMode, as: :mailing_mode
          option :quadrant, as: :quadrant
          option :unitNumber, as: :unit_number
        end
        option :city, as: :city
        option :state, as: :state
        option :zipCode, as: :zip_code
        option :carrierRoute, as: :carrier_route
        option :foreignAddress, as: :foreign_address
      end
      option :ownerMailingOptOutIndicator, as: :owner_mailing_opt_out_indicator
    end

    def to_hash
      hash = {}
      instance_variables.each { |var| hash[var.to_s.delete('@')] = instance_variable_get(var) }
      hash
    end
  end
end
