# frozen_string_literal: true

require 'spec_helper'

describe Corelogic::Collection do
  let(:records_count) { 3 }
  let(:raw_json) { json(:properties_response, count: records_count, fixture: './spec/fixture/properties_response.json') }
  let(:class_name) { Corelogic::Property.name }

  context 'with hash contains items key' do
    subject(:collection) { described_class.new(class_name, raw_hash) }

    let(:raw_hash) { JSON.parse(raw_json).deep_symbolize_keys }

    it { expect(collection.to_a.size).to eq(records_count) }
    it { is_expected.to be_instance_of(Array) and all(be_instance_of(class_name)) }

    describe '#to_a' do
      it { expect(collection.to_a.size).to eq(records_count) }
    end
  end
end
