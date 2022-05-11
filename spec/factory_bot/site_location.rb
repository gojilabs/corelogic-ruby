# frozen_string_literal: true

FactoryBot.define do
  factory :site_location_response, class: OpenStruct do
    transient do
      fixture { nil }
    end

    initialize_with do
      new(OpenStruct.new(JSON.parse(File.new(File.expand_path(fixture)).read)))
    end
  end
end
