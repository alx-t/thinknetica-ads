RSpec.describe GeocoderService::Client, type: :client do
  subject(:client) { described_class.new(connection: connection) }

  before do
    stubs.post('') { [status, headers, body.to_json] }
  end

  let(:status) { 201 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { { coordinates: [1, 2] } }

  describe '#geocode (valid ad_id)' do
    it 'returns a true value' do
      expect(subject.geocode('city')).to eq([1, 2])
    end
  end

  describe '#geocode (invalid ad_id)' do
    let(:status) { 422 }

    it 'returns a false value' do
      expect(subject.geocode('invalid')).to be_nil
    end
  end
end