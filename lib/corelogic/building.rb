# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class Building
    extend Dry::Initializer

    option :clip
    option :allBuildingsSummary, as: :all_buildings_summary do
      option :buildingsCount, as: :buildings_count
      option :unitsCount, as: :units_count
      option :roomsCount, as: :rooms_count
      option :bedroomsCount, as: :bedrooms_count
      option :bathroomsCount, as: :bathrooms_count
      option :fullBathroomsCount, as: :full_bathrooms_count
      option :halfBathroomsCount, as: :half_bathrooms_count
      option :oneQtrBathroomsCount, as: :one_qtr_bathrooms_count
      option :threeQtrBathroomsCount, as: :three_qtr_bathrooms_count
      option :bathroomFixturesCount, as: :bathroom_fixtures_count
      option :fireplacesCount, as: :fireplaces_count
      option :livingAreaSquareFeet, proc(&:to_i), as: :living_area_square_feet
      option :totalAreaSquareFeet, proc(&:to_i), as: :total_area_square_feet
      option :openAreasSquareFeet, as: :open_areas_square_feet
      option :officeSpaceSquareFeet, as: :office_space_square_feet
      option :elevatorsCount, as: :elevators_count
      option :loadingDocksCount, as: :loading_docks_count
      option :railSpursCount, as: :rail_spurs_count
      option :truckDoorsCount, as: :truck_doors_count
    end
    option :buildings, [], as: :buildings do
      option :structureId, as: :structure_id do
        option :sequenceNumber, as: :sequence_number
        option :compositeBuildingLinkageKey, as: :composite_building_linkage_key
        option :buildingName, as: :building_name
        option :buildingNumber, as: :building_number
        option :buildingSectionNumber, as: :building_section_number
        option :buildingComments, as: :building_comments
      end
      option :structureClassification, as: :structure_classification do
        option :buildingTypeCode, as: :building_type_code
        option :buildingClassCode, as: :building_class_code
        option :gradeTypeCode, as: :grade_type_code
        option :fireSprinklerTypeCode, as: :fire_sprinkler_type_code
        option :fireInsuranceTypeCode, as: :fire_insurance_type_code
      end
      option :structureFootprint, as: :structure_footprint do
        option :widthFeet, as: :width_feet
        option :depthFeet, as: :depth_feet
      end
      option :structureUnitsSummary, as: :structure_units_summary do
        option :vacantCount, as: :vacant_count
        option :residentialCount, as: :residential_count
        option :commercialCount, as: :commercial_count
      end
      option :structureVerticalProfile, as: :structure_vertical_profile do
        option :storiesCount, as: :stories_count
        option :storiesTypeCode, as: :stories_type_code
        option :floorNumber, as: :floor_number
      end
      option :constructionDetails, as: :construction_details do
        option :yearBuilt, as: :year_built
        option :effectiveYearBuilt, as: :effective_year_built
        option :buildingStyleTypeCode, as: :building_style_type_code
        option :buildingQualityTypeCode, as: :building_quality_type_code
        option :frameTypeCode, as: :frame_type_code
        option :foundationTypeCode, as: :foundation_type_code
        option :constructionTypeCode, as: :construction_type_code
        option :buildingRemodelTypeCode, as: :building_remodel_type_code
        option :buildingImprovementConditionCode, as: :building_improvement_condition_code
        option :buildingImprovementTypeCode, as: :building_improvement_type_code
        option :buildingImprovementValue, as: :building_improvement_value
      end
      option :structureExterior, as: :structure_exterior do
        option :patios, as: :patios do
          option :count, as: :count
          option :typeCode, as: :type_code
          option :areaSquareFeet, as: :area_square_feet
        end
        option :porches, as: :porches do
          option :count, as: :count
          option :typeCode, as: :type_code
          option :areaSquareFeet, as: :area_square_feet
          option :secondPorchAreaSquareFeet, as: :second_porch_area_square_feet
        end
        option :parking, as: :parking do
          option :typeCode, as: :type_code
          option :garageTypeCode, as: :garage_type_code
          option :parkingSpacesCount, as: :parking_spaces_count
          option :primaryAreaSquareFeet, as: :primary_area_square_feet
          option :secondAreaSquareFeet, as: :second_area_square_feet
          option :carportAreaSquareFeet, as: :carport_area_square_feet
        end
        option :pool, as: :pool do
          option :typeCode, as: :type_code, optional: true
          option :areaSquareFeet, as: :area_square_feet, optional: true
        end
        option :walls, as: :walls do
          option :typeCode, as: :type_code
        end
        option :roof, as: :roof do
          option :typeCode, as: :type_code
          option :coverTypeCode, as: :cover_type_code
        end
      end
      option :structureInterior, as: :structure_interior do
        option :attic, as: :attic do
          option :typeCode, as: :type_code
        end
        option :walls, as: :walls do
          option :typeCode, as: :type_code
        end
        option :basement, as: :basement do
          option :typeCode, as: :type_code
          option :finishTypeCode, as: :finish_type_code
          option :finishPercent, as: :finish_percent
        end
        option :flooring, as: :flooring do
          option :typeCode, as: :type_code
          option :coverTypeCode, as: :cover_type_code
        end
        option :ceiling, as: :ceiling do
          option :typeCode, as: :type_code
          option :heightFeet, as: :height_feet
        end
        option :bathroomFixtures, as: :bathroom_fixtures do
          option :count, as: :count
        end
      end
      option :interiorArea, as: :interior_area do
        option :universalBuildingAreaSquareFeet, as: :universal_building_area_square_feet
        option :universalBuildingAreaSquareFeetSourceCode, as: :universal_building_area_square_feet_source_code
        option :buildingAreaSquareFeet, as: :building_area_square_feet
        option :buildingAdjustedAreaSquareFeet, as: :building_adjusted_area_square_feet
        option :buildingGrossAreaSquareFeet, as: :building_gross_area_square_feet
        option :livingAreaSquareFeet, as: :living_area_square_feet
        option :aboveGradeAreaSquareFeet, as: :above_grade_area_square_feet
        option :groundFloorAreaSquareFeet, as: :ground_floor_area_square_feet
        option :basementAreaSquareFeet, as: :basement_area_square_feet
        option :finishedBasementAreaSquareFeet, as: :finished_basement_area_square_feet
        option :unfinishedBasementAreaSquareFeet, as: :unfinished_basement_area_square_feet
        option :aboveGroundFloorAreaSquareFeet, as: :above_ground_floor_area_square_feet
        option :buildingAdditionsAreaSquareFeet, as: :building_additions_area_square_feet
        option :entryLevelFloorAreaSquareFeet, as: :entry_level_floor_area_square_feet
        option :secondFloorAreaSquareFeet, as: :second_floor_area_square_feet
        option :thirdFloorAreaSquareFeet, as: :third_floor_area_square_feet
      end
      option :interiorRooms, as: :interior_rooms do
        option :totalCount, as: :total_count
        option :bedroomsCount, as: :bedrooms_count
        option :bathroomsCount, as: :bathrooms_count
        option :fullBathroomsCount, as: :full_bathrooms_count
        option :halfBathroomsCount, as: :half_bathrooms_count
        option :oneQtrBathroomsCount, as: :one_qtr_bathrooms_count
        option :threeQtrBathroomsCount, as: :three_qtr_bathrooms_count
        option :kitchensCount, as: :kitchens_count
        option :familyRoomsCount, as: :family_rooms_count
        option :livingRoomsCount, as: :living_rooms_count
        option :basementRoomsCount, as: :basement_rooms_count
      end
      option :structureFeatures, as: :structure_features do
        option :airConditioning, as: :air_conditioning do
          option :typeCode, as: :type_code
        end
        option :firePlaces, as: :fire_places do
          option :typeCode, as: :type_code
          option :count, as: :count
        end
        option :heating, as: :heating do
          option :typeCode, as: :type_code
        end
        option :plumbing, as: :plumbing do
          option :typeCode, as: :type_code
        end
        option :passengerElevators, as: :passenger_elevators do
          option :count, as: :count
        end
        option :dormerWindows, as: :dormer_windows do
          option :count, as: :count
        end
      end
    end
  end
end
