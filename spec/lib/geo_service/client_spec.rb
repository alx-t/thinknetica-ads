RSpec.describe GeocoderService::Client, type: :client do
  subject(:client) { described_class.new(connection: connection) }

  before do
    stubs.post('') { [status, headers, body.to_json] }
  end

  let(:status) { 201 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }

  describe '#geocode (valid ad_id)' do
    it 'returns a true value' do
      expect(subject.geocode?(99)).to be_truthy
    end
  end

  describe '#geocode (invalid ad_id)' do
    let(:status) { 422 }

    it 'returns a false value' do
      expect(subject.geocode?(99)).to be_falsey
    end
  end
end