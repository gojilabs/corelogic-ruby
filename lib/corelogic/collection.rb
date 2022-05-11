# frozen_string_literal: true

module Corelogic
  class Collection
    extend Forwardable
    def_delegators :@members, *[].public_methods

    DEFAULT_RECORDS_LIMIT = 10
    attr_reader :members, :klass, :metadata, :items, :total_pages, :current_page, :limit_value, :total_records

    def initialize(klass, raw_hash)
      @klass = klass.is_a?(::String) ? ::Object.const_get(klass) : klass
      @metadata = raw_hash[:metadata]
      @items = raw_hash[:items]

      @total_pages = @metadata[:totalPages] || 1
      @current_page = @metadata[:pageNumber] || 1
      @limit_value = @metadata[:pageSize] || DEFAULT_RECORDS_LIMIT
      @total_records = @metadata[:totalRecords]

      @members = @items.present? ? @items.map { |record| @klass.new(**record) } : []
    end

    def to_a
      @members
    end
  end
end
