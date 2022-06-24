# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class RentalAmountModel
    extend Dry::Initializer

    option :data do
      option :clip
      option :runDate, as: :run_date
      option :modelOutput, as: :model_output do
        option :estimatedValue, as: :estimated_value
        option :forecastStandardDeviation, as: :forecast_standard_deviation
      end
      # option :estimatedValueRange, as: :estimated_value_range do
      #   option :high
      #   option :low
      # end
      # option :additionalValues, as: :additional_values do
      #   option :capRate, as: :cap_rate
      # end
    end
  end
end
