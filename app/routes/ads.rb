class AdsApi < Sinatra::Application
  attr_reader :validation_result

  namespace '/api/v1' do
    before do
        content_type 'application/json'
    end

    get '/ads' do
      AdSerializer.new(Ad.all).to_json
    end  

    post '/ads' do
      payload = JSON.parse(request.body.read, symbolize_names: true)
      return error_message(validation_result.errors.messages.map(&:to_h)) unless valid?(payload)
      result = Ads::CreateService.new(payload).call
      if result.success?
        status 201
        AdSerializer.new(result.ad).to_json
      else
        error_message(result.ad)
      end
    end
  end

  def error_message(messages)
    status 422
    { error: messages }.to_json
  end

  def valid?(payload)
    contract = AdContract.new
    @validation_result ||= contract.call(payload)
    @validation_result.success?
  end
end
