module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if @ad.valid?
        @ad.save
        geocoder_service.geocode?(@ad.id)
      else
        fail!(@ad.errors)
      end
    end

    private

    def geocoder_service
      @geocoder_service ||= GeocoderService::Client.new
    end
  end
end