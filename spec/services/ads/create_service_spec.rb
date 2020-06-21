RSpec.describe Ads::CreateService do
  subject { described_class }

  let(:user_id) { 101 }
  let(:geo_service) { instance_double('GeoClient') }

  before do
    allow(geo_service).to receive(:'geocode')
      .and_return([1, 2])

    allow(GeocoderService::Client).to receive(:new)
      .and_return(geo_service)      
  end  

  context 'valid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: 'City'
      }
    end

    it 'creates a new ad' do
      expect { subject.call(ad: ad_params, user_id: user_id) }
        .to change { Ad.count }.from(0).to(1)
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id)

      expect(result.ad).to be_kind_of(Ad)
    end
  end

  context 'invalid parameters' do
    let(:ad_params) do
      {
        title: 'Ad title',
        description: 'Ad description',
        city: ''
      }
    end

    it 'does not create ad' do
      expect { subject.call(ad: ad_params, user_id: user_id) }
        .not_to change { Ad.count }
    end

    it 'assigns ad' do
      result = subject.call(ad: ad_params, user_id: user_id)

      expect(result.ad).to be_kind_of(Ad)
    end
  end
end