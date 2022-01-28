# frozen_string_literal: true

class PartnerReservationIntegrator
  attr_accessor :errors

  def initialize(params)
    @params = params
    @errors = []
  end

  def perform
    result, schema = transform_to_hometime_schema
    return false if @errors.present?

    record = "#{schema}Mapper".constantize.transform(result.values)

    ActiveRecord::Base.transaction do
      guest = Guest.find_or_initialize_by(email: record.guest.email)
      guest.update!(record.guest.attributes.except(:email))

      reservation = Reservation.find_or_initialize_by(code: record.code)
      reservation.update!(record.attributes.except(:code, :guest).merge(guest_id: guest.id))
    end

    true
  end

  private

  # get list of available contract class automatically
  # loop through each contract to get first valid contract
  # return Dry::Validation::Result with data type as defined on contract class
  def transform_to_hometime_schema
    result = nil
    used_schema = nil
    schemas = partner_schemas

    schemas.each do |schema|
      result = schema.constantize.new.call(@params)
      used_schema = schema

      if result.success?
        @errors = []
        break
      end

      @errors << { "#{schema}": result.errors.to_h }
    end

    [result, used_schema]
  end

  def partner_schemas
    schemas = []
    Dir.glob('app/contracts/**/*.rb').each do |f|
      next if f.eql?('app/contracts/application_contract.rb')

      schemas << f.split('/')[-1].camelize.split('.').first
    end

    schemas
  end
end
