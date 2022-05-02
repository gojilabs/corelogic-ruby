# frozen_string_literal: true

require 'spec_helper'

describe Corelogic::API::PropertiesRepository do
  subject(:properties) { Corelogic.properties }

  let(:connection) { Corelogic.container['connection'] }
  let(:oauth_error_body) { json(:oauth_error_body) }
  let(:oauth_success_body) { json(:oauth_success_body) }

  let(:clip) { '8623812756' }

  context 'authenticated connection' do
    before do
      allow(connection).to receive(:authenticated?).and_return(true)
    end

    describe '#search' do
      let(:response) { json(:properties_response, fixture: './spec/fixture/properties_response.json') }

      before do
        stub_request(:get, "#{Corelogic::Connection::BASE_PATH}search")
          .to_return(
            body:    response,
            headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' }
          )
      end

      it 'requests the correct resource on GET' do
        properties.search
        expect(a_get('search')).to have_been_made
      end

      it 'returns properties' do
        result = properties.search
        expect(result).to be_instance_of(Array) and all(be_instance_of(Corelogic::Property))
        expect(result).to matches_properties(JSON.parse(response)['items'])
      end
    end

    describe '#ownership' do
      let(:response) { json(:ownership_response, fixture: './spec/fixture/ownership_response.json') }

      before do
        stub_request(:get, /ownership/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests the correct resource on GET' do
        properties.ownership(clip)
        expect(a_get("#{clip}/ownership")).to have_been_made
      end

      it 'returns `Corelogic::Ownership` with clip' do
        result = properties.ownership(clip)
        expect(result).to be_instance_of(Corelogic::Ownership)
        expect(result).to matches_properties(JSON.parse(response)['data'])
      end
    end

    describe '#buildings' do
      let(:response) { json(:buildings_response, fixture: './spec/fixture/building_response.json') }

      before do
        stub_request(:get, /buildings/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests the correct resource on GET' do
        properties.building(clip)
        expect(a_get("#{clip}/buildings")).to have_been_made
      end

      it 'returns `Corelogic::Building` with clip' do
        result = properties.building(clip)
        expect(result).to be_instance_of(Corelogic::Building)
        expect(result).to matches_properties(JSON.parse(response)['data'])
      end
    end

    describe '#tax_assessment' do
      let(:response) { json(:tax_assessments_response, fixture: './spec/fixture/tax_assessments_response.json') }

      before do
        stub_request(:get, /tax-assessments/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests the correct resource on GET' do
        properties.tax_assessment(clip)
        expect(a_get("#{clip}/tax-assessments/latest")).to have_been_made
      end

      it 'returns `Corelogic::TaxAssessments` with clip' do
        result = properties.tax_assessment(clip)
        expect(result).to be_instance_of(Array) and all(be_instance_of(Corelogic::TaxAssessment))
        expect(result.first).to matches_properties(JSON.parse(response)['items'].first)
      end
    end

    describe '#site-location' do
      let(:response) { json(:site_location_response, fixture: './spec/fixture/site_location_response.json') }

      before do
        stub_request(:get, /site-location/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests the correct resource on GET' do
        properties.site_location(clip)
        expect(a_get("#{clip}/site-location")).to have_been_made
      end

      it 'returns `Corelogic::SiteLocation` with clip' do
        result = properties.site_location(clip)
        expect(result).to be_instance_of(Corelogic::SiteLocation)
        expect(result).to matches_properties(JSON.parse(response)['data'])
      end
    end

    describe '#owner_transfer' do
      let(:response) { json(:ownership_transfers_response, fixture: './spec/fixture/ownership_transfers_response.json') }

      before do
        stub_request(:get, /ownership-transfers/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests market latest resource on GET' do
        properties.ownership_transfers(clip)
        expect(a_get("#{clip}/ownership-transfers/market/latest")).to have_been_made
      end

      it 'requests market all resource on GET' do
        properties.ownership_transfers(clip, 'market', 'all')
        expect(a_get("#{clip}/ownership-transfers/market/all")).to have_been_made
      end

      it 'returns `Corelogic::OwnershipTransfers` with clip' do
        result = properties.ownership_transfers(clip)
        expect(result).to be_instance_of(Array) and all(be_instance_of(Corelogic::OwnershipTransfer))
        expect(result.first).to matches_properties(JSON.parse(response)['items'].first)
      end
    end

    describe '#property_detail' do
      let(:property) { build(:property, clip:, fixture: './spec/fixture/property.json') }
      let(:response) { json(:property_detail_response, fixture: './spec/fixture/property_detail_response.json') }

      before do
        stub_request(:get, /property-detail/)
          .to_return(body:    response,
                     headers: { content_type: 'application/vnd.corelogic.v1+json;charset=UTF-8' })
      end

      it 'requests the correct resource on GET' do
        properties.property_detail(property)
        expect(a_get("#{clip}/property-detail")).to have_been_made
      end

      it 'returns `Corelogic::PropertyDetail` with clip' do
        result = properties.property_detail(property)

        expect(result).to be_instance_of(Corelogic::Property)
        expect(result.building).to be_instance_of(Corelogic::Building)
        expect(result.building).to matches_properties(JSON.parse(response)['buildings']['data'])

        expect(result.ownership).to be_instance_of(Corelogic::Ownership)
        expect(result.ownership).to matches_properties(JSON.parse(response)['ownership']['data'])

        expect(result.ownership_transfers).to be_instance_of(Array) and all(be_instance_of(Corelogic::OwnershipTransfer))
        expect(result.ownership_transfers).to matches_properties(JSON.parse(response)['mostRecentOwnerTransfer']['items'])

        expect(result.site_location).to be_instance_of(Corelogic::SiteLocation)
        expect(result.site_location).to matches_properties(JSON.parse(response)['siteLocation']['data'])

        expect(result.tax_assessment).to be_instance_of(Array) and all(be_instance_of(Corelogic::TaxAssessment))
        expect(result.tax_assessment).to matches_properties(JSON.parse(response)['taxAssessment']['items'])
      end
    end
  end

  context 'not authenticated connection' do
    let(:properties_response) { json(:properties_response, fixture: './spec/fixture/properties_response.json') }

    before do
      allow(connection).to receive(:authenticated?).and_return(false)
      connection.bearer_token = nil
      stub_request(:post, Corelogic::Authenticator::OAUTH_URL)
        .with(query: { grant_type: 'client_credentials' })
        .to_return({ body: oauth_success_body, headers: { content_type: 'application/json' }, status: 200 })
      stub_request(:get, "#{Corelogic::Connection::BASE_PATH}search")
        .to_return({ body: properties_response, headers: { content_type: 'application/json' }, status: 200 })
    end

    it 'authenticates connection' do
      properties.search
      expect(connection.bearer_token).to be_a String
    end
  end

  context 'the bearer token has expired' do
    let(:properties_response) { json(:properties_response, fixture: './spec/fixture/properties_response.json') }

    before do
      allow(connection).to receive(:authenticated?).and_return(true)
      stub_request(:get, "#{Corelogic::Connection::BASE_PATH}search")
        .to_return(
          { body: oauth_error_body, headers: { content_type: 'application/json' }, status: 401 },
          { body: properties_response, headers: { content_type: 'application/json' }, status: 200 }
        )

      stub_request(:post, Corelogic::Authenticator::OAUTH_URL)
        .with(query: { grant_type: 'client_credentials' })
        .to_return({ body: oauth_success_body, headers: { content_type: 'application/json' }, status: 200 })

      properties.search
    end

    it 'tries to re-authenticate' do
      expect(a_get('search')).to have_been_made.times(2)
      expect(a_request(:post, Corelogic::Authenticator::OAUTH_URL).with(query: { grant_type: 'client_credentials' })).to have_been_made.times(1)
    end
  end
end
