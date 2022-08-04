# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class AutomatedValueModel
    extend Dry::Initializer

    option :summary do
      option :confidenceScore, as: :confidence_score
      option :estimatedValue, as: :estimated_value
      option :forecastStandardDeviation, as: :forecast_standard_deviation 
      option :highValue, as: :high_value
      option :lowValue, as: :low_value
      option :processedDate, as: :processed_date
    end
  end
end
