# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_many :sent_messages, class_name: 'Message',
           foreign_key: 'sender_id', dependent: :destroy

  has_many :received_messages, class_name: 'Message',
           foreign_key: 'recipient_id', dependent: :destroy

  validates :email, presence: true, uniqueness: true

  scope :by_emails, ->(emails) { where(email: emails) }
  scope :by_email, ->(email) { find_by(email: email) }

  def send_message(recipient, body)
    sent_messages.create(recipient: recipient, body: body)
  end
end
