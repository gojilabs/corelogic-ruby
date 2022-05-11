# frozen_string_literal: true

require 'spec_helper'

describe Corelogic do
  it 'has a version number' do
    expect(Corelogic::VERSION).not_to be_nil
  end

  describe 'Corelogic#container' do
    it { expect(described_class.container.keys.size).to eq(3) }

    it 'contains `authenticator` key' do
      expect(described_class.container.resolve('authenticator')).to be
    end

    it '`authenticator` should be an instance of `Corelogic::Authenticator`' do
      expect(described_class.container.resolve('authenticator')).to be_an_instance_of(Corelogic::Authenticator)
    end

    it 'contains `connection` key' do
      expect(described_class.container.resolve('connection')).to be
    end

    it '`connection` should be an instance of `Corelogic::Connection`' do
      expect(described_class.container.resolve('connection')).to be_an_instance_of(Corelogic::Connection)
    end

    it 'contains `response_parser` key' do
      expect(described_class.container.resolve('response_parser')).to be
    end
  end
end
