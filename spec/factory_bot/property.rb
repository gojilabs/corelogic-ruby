# frozen_string_literal: true

FactoryBot.define do
  factory :properties_response, class: OpenStruct do
    transient do
      count { 1 }
      fixture { nil }
    end

    initialize_with do
      new(OpenStruct.new(JSON.parse(File.new(File.expand_path(fixture)).read)))
    end

    after(:build) do |response, context|
      response.items = Array.new(context.count).map { response.items.first }
    end
  end

  factory :property, class: Corelogic::Property do
    transient do
      clip { nil }
      fixture { nil }
    end

    initialize_with do
      json = JSON.parse(File.new(File.expand_path(fixture)).read)
      Corelogic::Property.new(**json.deep_symbolize_keys)
    end

    after(:build) do |obj, context|
      obj.clip = context.clip
    end
  end

  factory :property_detail_response, class: OpenStruct do
    transient do
      fixture { nil }
    end

    initialize_with do
      new(OpenStruct.new(JSON.parse(File.new(File.expand_path(fixture)).read)))
    end
  end
end
