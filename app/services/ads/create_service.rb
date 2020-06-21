module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocoder_service, default: proc { GeocoderService::Client.new }

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id
      @ad.lat, @ad.lon = coordinates(@ad.city)

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end

    private

    def coordinates(city)
      coordinates = geocoder_service.geocode(city)
      return [nil, nil] if coordinates.blank?
      coordinates
    end
  end
end