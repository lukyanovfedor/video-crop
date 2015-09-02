class Video
  include Mongoid::Document

  field :timeline, type: Timeline

  mount_uploader :file, VideoUploader

  embedded_in :inquiry

  validates :file, presence: true, integrity: true
  validates :timeline, presence: true, timeline: true
end
