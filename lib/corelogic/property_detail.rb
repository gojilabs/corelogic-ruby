# frozen_string_literal: true

require 'dry-initializer'

module Corelogic
  class PropertyDetail
    extend Dry::Initializer

    option :buildings
  end
end
