class Inquiry
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include AASM

  STATES = %i(failed scheduled processing done)

  belongs_to :user
  embeds_one :video, cascade_callbacks: true

  field :state, type: Symbol

  index state: 1
  index 'video._id': 1

  validates :state, :video, presence: true
  validates :state, inclusion: { in: STATES }

  after_create :crop_video

  def self.find_by_video(video_id)
    where('video._id': video_id).first
  end

  aasm column: :state, whiny_transitions: false, enum: true do
    state :failed
    state :scheduled, initial: true
    state :processing
    state :done

    event :process do
      transitions from: :scheduled, to: :processing
    end

    event :fail do
      transitions from: :processing, to: :failed
    end

    event :done do
      transitions from: :processing, to: :done
    end

    event :restart do
      transitions from: :failed, to: :scheduled
    end
  end

  def crop_video
    self.video.file.ready_for_crop.recreate_versions! :cropped
  end
end
