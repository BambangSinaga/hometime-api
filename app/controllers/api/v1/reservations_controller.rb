# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        integrator = PartnerReservationIntegrator.new(reservation_params)

        if integrator.perform
          render status: :created
        else
          render json: integrator.errors, status: :unprocessable_entity
        end
      end

      private

      def reservation_params
        params.permit!.to_h.symbolize_keys
      end
    end
  end
end
