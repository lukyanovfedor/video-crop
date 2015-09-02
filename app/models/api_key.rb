class ApiKey
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :token, type: String

  embedded_in :user

  validates :token, presence: true

  before_validation :set_token

  def self.generate_token
    token = SecureRandom.hex(16)

    begin
      find_by(token: token)
      generate_token
    rescue Mongoid::Errors::DocumentNotFound
      token
    end
  end

  private

    def set_token
      self.token ||= ApiKey.generate_token
    end

end
