module Ads
  class CreateService
    prepend BasicService

    attr_reader :ad

    option :ad do
      option :title
      option :description
      option :city
      option :user_id
    end

    def call
      @ad = ::Ad.new(@ad.to_h)
      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end
  end
end