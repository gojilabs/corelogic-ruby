# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class SiteLocation
    extend Dry::Initializer

    option :clip
    option :coordinatesParcel, as: :coordinates_parcel do
      option :lat, as: :lat
      option :lng, as: :lng
    end
    option :coordinatesBlock, as: :coordinates_block do
      option :lat, as: :lat
      option :lng, as: :lng
    end
    option :locationLegal, as: :location_legal do
      option :subdivisionName, as: :subdivision_name
      option :subdivisionTractNumber, as: :subdivision_tract_number
      option :subdivisionPlatBookNumber, as: :subdivision_plat_book_number
      option :subdivisionPlatPageNumber, as: :subdivision_plat_page_number
      option :blockNumber, as: :block_number
      option :blockNumberSuffix, as: :block_number_suffix
      option :lotNumber, as: :lot_number
      option :lotNumberSuffix, as: :lot_number_suffix
      option :description, as: :description
    end
    option :locationSurvey, as: :location_survey do
      option :range, as: :range
      option :township, as: :township
      option :section, as: :section
      option :quarterSection, as: :quarter_section
    end
    option :neighborhood, as: :neighborhood do
      option :code, as: :code
      option :name, as: :name
    end
    option :municipality, as: :municipality do
      option :code, as: :code
      option :name, as: :name
    end
    option :town, as: :town do
      option :code, as: :code
    end
    option :jurisdictionCounty, as: :jurisdiction_county do
      option :code, as: :code
    end
    option :cbsa, as: :cbsa do
      option :code, as: :code
      option :type, as: :type
    end
    option :censusTract, as: :census_tract do
      option :id, as: :id
    end
    option :taxRateArea, as: :tax_rate_area do
      option :code, as: :code
    end
    option :taxDistrict, as: :tax_district do
      option :name, as: :name
    end
    option :landUseAndZoningCodes, as: :land_use_and_zoning_codes do
      option :propertyTypeCode, as: :property_type_code
      option :landUseCode, as: :land_use_code
      option :stateLandUseCode, as: :state_land_use_code
      option :stateLandUseDescription, as: :state_land_use_description
      option :countyLandUseCode, as: :county_land_use_code
      option :countyLandUseDescription, as: :county_land_use_description
      option :zoningCode, as: :zoning_code
      option :zoningCodeDescription, as: :zoning_code_description
      option :isManufacturedHome, as: :is_manufactured_home
    end
    option :lot, as: :lot do
      option :areaAcres, as: :area_acres
      option :areaSquareFeet, as: :area_square_feet
      option :areaSquareFeetUsable, as: :area_square_feet_usable
      option :depthFeet, as: :depth_feet
      option :frontFeet, as: :front_feet
      option :shapeCode, as: :shape_code
      option :topographyType, as: :topography_type
      option :easementTypeCode, as: :easement_type_code
    end
    option :utilities, as: :utilities do
      option :fuelTypeCode, as: :fuel_type_code
      option :electricityWiringTypeCode, as: :electricity_wiring_type_code
      option :sewerTypeCode, as: :sewer_type_code
      option :utilitiesTypeCode, as: :utilities_type_code
      option :waterTypeCode, as: :water_type_code
    end
  end
end
