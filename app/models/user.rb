class User < ApplicationRecord
  has_one_attached :image
  belongs_to :role
  mount_uploader :image, ImageUploader
  validates :image, content_type: { in: ['image/png'], message: 'must be a PNG image' }


  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
