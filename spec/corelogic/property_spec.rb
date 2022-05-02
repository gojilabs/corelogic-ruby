# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Corelogic::Property do
  let(:clip) { '8623812756' }
  let(:property) { build(:property, clip:, fixture: './spec/fixture/property.json') }
  let(:connection) { Corelogic.container['connection'] }

  describe '#load_details' do
    before do
      allow(connection).to receive(:authenticated?).and_return(true)
      stub_request(:get, /property-detail/)
        .to_return(body:    File.new(File.expand_path('./spec/fixture/property_detail_response.json')),
                   headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
    end

    it 'requests the correct resource on GET' do
      property.load_details
      expect(a_get("#{property.clip}/property-detail")).to have_been_made
    end

    it 'returns `Corelogic::Property` with loaded data' do
      property.load_details

      expect(property).to be_instance_of(described_class)
      expect(property.ownership).to be_instance_of(Corelogic::Ownership)
      expect(property.building).to be_instance_of(Corelogic::Building)
      expect(property.tax_assessment).to be_instance_of(Array) and all(be_instance_of(Corelogic::TaxAssessment))
      expect(property.site_location).to be_instance_of(Corelogic::SiteLocation)
      expect(property.ownership_transfers).to be_instance_of(Array) and all(be_instance_of(Corelogic::OwnershipTransfer))
    end
  end
end
