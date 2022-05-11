# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :matches_properties do
  match_unless_raises Exception do |actual|
    actual_hash = to_hash(actual)
    expected_hash = to_snake_case_keys_hash(expected)

    expect(actual_hash).to eq(expected_hash)
  end

  failure_message do
    rescued_exception ? rescued_exception.message : super()
  end

  def to_snake_case_keys_hash(obj)
    return obj.map { |item| to_snake_case_keys_hash(item) } if obj.is_a?(Array)

    obj.deep_transform_keys!(&:underscore).deep_transform_keys!(&:to_sym)
  end

  def to_hash(obj)
    return obj.map { |item| to_hash(item) } if obj.is_a?(Array)

    case obj.class
    when Dry::Initializer
      hash = obj.class.dry_initializer.public_attributes(obj)

      hash.transform_values do |v|
        if v.is_a?(Array)
          v.map { |e| e.to_h.deep_transform_keys(&:to_sym) }
        else
          v.respond_to?(:to_h) ? v.to_h.deep_transform_keys(&:to_sym) : v
        end
      end
    end
  end
end
