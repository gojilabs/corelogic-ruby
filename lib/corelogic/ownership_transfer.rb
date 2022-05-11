# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class OwnershipTransfer
    extend Dry::Initializer

    option :clip
    option :transactionDetails, as: :transaction_details do
      option :primaryCategoryCode, as: :primary_category_code
      option :deedCategoryCode, as: :deed_category_code
      option :saleDateDerived, as: :sale_date_derived
      option :saleRecordingDateDerived, as: :sale_recording_date_derived
      option :saleAmount, as: :sale_amount
      option :saleTypeCode, as: :sale_type_code
      option :saleDocumentTypeCode, as: :sale_document_type_code
      option :saleDocumentNumber, as: :sale_document_number
      option :saleBookNumber, as: :sale_book_number
      option :salePageNumber, as: :sale_page_number
      option :ownershipTransferPercent, as: :ownership_transfer_percent
      option :multiOrSplitParcelCode, as: :multi_or_split_parcel_code
      option :isCashPurchase, as: :is_cash_purchase
      option :isMortgagePurchase, as: :is_mortgage_purchase
      option :isInterfamilyRelated, as: :is_interfamily_related
      option :isInvestorPurchase, as: :is_investor_purchase
      option :isResale, as: :is_resale
      option :isShortSale, as: :is_short_sale
      option :isForeclosureReo, as: :is_foreclosure_reo
      option :isForeclosureReoSale, as: :is_foreclosure_reo_sale
    end
    option :recordedPropertyAddress, as: :recorded_property_address do
      option :streetAddress, as: :street_address
      option :streetAddressParsed, as: :street_address_parsed do
        option :houseNumber, as: :house_number
        option :houseNumberSuffix, as: :house_number_suffix
        option :houseNumber2, as: :house_number2
        option :direction, as: :direction
        option :streetName, as: :street_name
        option :mode, as: :mode
        option :quadrant, as: :quadrant
        option :unitNumber, as: :unit_number
      end
      option :city, as: :city
      option :state, as: :state
      option :zipCode, as: :zip_code
      option :carrierRoute, as: :carrier_route
      option :county, as: :county
    end
    option :titleCompany, as: :title_company do
      option :name, as: :name
      option :code, as: :code
    end
    option :propertyDetails, as: :property_details do
      option :actualYearBuilt, as: :actual_year_built
      option :effectiveYearBuilt, as: :effective_year_built
      option :isResidentialProperty, as: :is_residential_property
      option :isNewConstruction, as: :is_new_construction
    end
    option :landUseAndZoningCodes, as: :land_use_and_zoning_codes do
      option :propertyTypeCode, as: :property_type_code, optional: true
      option :landUseCode, as: :land_use_code, optional: true
      option :stateLandUseCode, as: :state_land_use_code, optional: true
      option :stateLandUseDescription, as: :state_land_use_description, optional: true
      option :countyLandUseCode, as: :county_land_use_code, optional: true
      option :countyLandUseDescription, as: :county_land_use_description, optional: true
      option :zoningCode, as: :zoning_code, optional: true
      option :zoningCodeDescription, as: :zoning_code_description, optional: true
      option :isManufacturedHome, as: :is_manufactured_home, optional: true
    end
    option :buyerDetails, as: :buyer_details do
      option :buyerNames, [], as: :buyer_names do
        option :sequenceNumber, as: :sequence_number
        option :fullName, as: :full_name
        option :lastName, as: :last_name
        option :firstNameAndMiddleInitial, as: :first_name_and_middle_initial
        option :isCorporate, as: :is_corporate
      end
      option :relationshipTypeCode, as: :relationship_type_code
      option :etalCode, as: :etal_code
      option :occupancyCode, as: :occupancy_code
      option :ownershipRightsCode, as: :ownership_rights_code
      option :mailingAddress, as: :mailing_address do
        option :careOfName, as: :care_of_name
        option :streetAddress, as: :street_address
        option :streetAddressParsed, as: :street_address_parsed do
          option :houseNumber, as: :house_number
          option :houseNumberSuffix, as: :house_number_suffix
          option :houseNumber2, as: :house_number2
          option :direction, as: :direction
          option :streetName, as: :street_name
          option :mode, as: :mode
          option :quadrant, as: :quadrant
          option :unitNumber, as: :unit_number
        end
        option :city, as: :city
        option :state, as: :state
        option :zipCode, as: :zip_code
        option :carrierRoute, as: :carrier_route
      end
      option :hasPartialInterest, as: :has_partial_interest
      option :mailingOptOutIndicator, as: :mailing_opt_out_indicator
    end
    option :sellerDetails, as: :seller_details do
      option :sellerNames, [], as: :seller_names do
        option :sequenceNumber, as: :sequence_number
        option :fullName, as: :full_name
      end
    end
  end
end
