module GeocoderService
  module Api
    def geocode?(ad_id)
      response = connection.post('') do |request| 
        request.params['id'] = ad_id
      end

      return true if response.status == 201
      false
    end
  end
end