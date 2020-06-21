module GeocoderService
  module Api
    def geocode(city)
      response = connection.post('') do |request| 
        request.params['city'] = city
      end
      response.body['coordinates'] if response.success?
    end
  end
end