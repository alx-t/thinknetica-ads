class Ad < Sequel::Model
  def validate
    super
    validates_presence :title
    validates_presence :description
    validates_presence :city
    validates_presence :user_id
  end 
end