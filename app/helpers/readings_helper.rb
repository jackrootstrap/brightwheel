module ReadingsHelper
    private

    def cached_device_readings
      Rails.cache.read(device_id)
    end

    def device_readings
      render json: {error: "device not found"}, status: :not_found and return unless cached_device_readings
      JSON.parse(cached_device_readings)
    end

    def latest_reading(readings)
      r = readings.map {|reading| {timestamp: reading["timestamp"].to_datetime, count: reading["count"]}}
      r.max_by { |hash| hash[:timestamp] }
    end

    def cumulative_count(readings)
      readings.map{|reading| reading["count"]}.inject(0, &:+)
    end

    def verify_payload
      render json: {error: "Payload ignored"}, status: :unprocessable_entity and return if cached_device_readings
    end
    
    def validate_params
      render json: {error: "Invalid payload params"}, status: :unprocessable_entity and return unless valid_params?
    end

    def valid_params?
      params[:id].present? && readings_param.present?
    end

    def validate_recordings
      valid_readings = readings_param.all?{ |reading| reading["count"] > 0 && reading["timestamp"].to_datetime } rescue false
      render json: {error: "Invalid readings"}, status: :unprocessable_entity and return unless valid_readings
    end
end