module Api
  module V1
    class ReadingsController < ApplicationController
      include ReadingsHelper
      before_action :device_readings, only: [:latest, :cumulative]
      before_action :validate_params,:verify_payload, :validate_recordings, only: [:create]

      def create
        Rails.cache.write(device_id, readings_param.to_json)
        render json: {message: "sucess"}, status: :ok
      end

      def latest
        render json: {latest_reading: latest_reading(device_readings)}, status: :ok
      end

      def cumulative
        render json: {cumulative_count: cumulative_count(device_readings)}, status: :ok
      end

      private

      def device_id
        params[:id]
      end

      def readings_param
        params[:readings]
      end
    end
  end
end
