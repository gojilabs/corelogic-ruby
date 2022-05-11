# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class TaxAssessment
    extend Dry::Initializer

    option :clip
    option :taxAmount, as: :tax_amount do
      option :billedYear, as: :billed_year
      option :delinquentYear, as: :delinquent_year
      option :areaCode, as: :area_code
      option :areaCodeDescription, as: :area_code_description
      option :propertyTaxRate, as: :property_tax_rate
      option :calculatedTotalExemptionAmount, as: :calculated_total_exemption_amount
      option :totalTaxExemptionAmount, as: :total_tax_exemption_amount
      option :totalTaxAmount, as: :total_tax_amount
      option :countyTaxAmount, as: :county_tax_amount
      option :schoolTaxAmount, as: :school_tax_amount
      option :townTaxAmount, as: :town_tax_amount
      option :villageTaxAmount, as: :village_tax_amount
      option :netTaxAmount, as: :net_tax_amount
    end
    option :taxExemptions, as: :tax_exemptions do
      option :commercial, [], as: :commercial
      option :residential, [], as: :residential
    end
    option :assessedValue, as: :assessed_value do
      option :taxAssessedYear, as: :tax_assessed_year
      option :calculatedTotalValue, as: :calculated_total_value
      option :calculatedLandValue, as: :calculated_land_value
      option :calculatedImprovementValue, as: :calculated_improvement_value
      option :calculatedImprovementValuePercentage, as: :calculated_improvement_value_percentage
      option :calculatedTotalValueSourceCode, as: :calculated_total_value_source_code
      option :taxableValue, as: :taxable_value
      option :taxableImprovementValue, as: :taxable_improvement_value
      option :taxableLandValue, as: :taxable_land_value
      option :taxableOtherValue, as: :taxable_other_value
    end
    option :taxrollUpdate, as: :taxroll_update do
      option :lastAssessorUpdateDate, as: :last_assessor_update_date
      option :taxrollCertificationDate, as: :taxroll_certification_date
    end
    option :schoolDistricts, as: :school_districts do
      option :school, as: :school do
        option :code, as: :code
        option :name, as: :name
        option :elementary, as: :elementary do
          option :code, as: :code
          option :name, as: :name
        end
        option :middle, as: :middle do
          option :code, as: :code
          option :name, as: :name
        end
        option :high, as: :high do
          option :code, as: :code
          option :name, as: :name
        end
        option :communityCollege, as: :community_college do
          option :code, as: :code
          option :name, as: :name
        end
      end
    end
    option :serviceDistricts, as: :service_districts do
      option :fire, as: :fire do
        option :code, as: :code
        option :name, as: :name
      end
      option :trash, as: :trash do
        option :code, as: :code
        option :name, as: :name
      end
      option :lighting, as: :lighting do
        option :code, as: :code
        option :name, as: :name
      end
      option :tax, as: :tax do
        option :code, as: :code
        option :name, as: :name
      end
      option :sewer, as: :sewer do
        option :code, as: :code
        option :name, as: :name
      end
      option :utility, as: :utility do
        option :code, as: :code
        option :name, as: :name
      end
      option :water, as: :water do
        option :code, as: :code
        option :name, as: :name
      end
    end
  end
end
