class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  embeds_one :api_key, cascade_callbacks: true
  has_many :inquiries, dependent: :destroy

  index({ 'api_key.token': 1 }, { unique: true })

  def self.find_by_token(token)
    where('api_key.token': token).first
  end
end
