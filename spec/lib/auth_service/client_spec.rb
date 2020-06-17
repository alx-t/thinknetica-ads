 RSpec.describe AuthService::Client, type: :client do
  subject(:client) { described_class.new(connection: connection) }

  before do
    stubs.post('auth') { [status, headers, body.to_json] }
  end

  let(:status) { 200 }
  let(:headers) { {'Content-Type' => 'application/json'} }
  let(:body) { {} }

  describe '#auth (valid token)' do
    let(:user_id) { 101 }
    let(:body) { { 'meta' => { 'user_id' => user_id } } }

    it 'returns user_id' do
      expect(subject.auth('valid.token')).to eq(user_id)
    end
  end  

  describe '#auth (invalid token)' do
    let(:status) { 403 }

    it 'returns a nil value' do
      expect(subject.auth('invalid.token')).to be_nil
    end
  end

  describe '#auth (nil token)' do
    let(:status) { 403 }

    it 'returns a nil value' do
      expect(subject.auth(nil)).to be_nil
    end
  end 
end