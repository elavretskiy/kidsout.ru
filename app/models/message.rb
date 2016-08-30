# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer          not null
#  recipient_id :integer          not null
#  body         :string           not null
#  is_read      :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_sent      :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'User', foreign_key: 'recipient_id'

  validates :sender_id, :recipient_id, :body, presence: true

  before_save :set_is_sent

  scope :by_ids, ->(ids) { where(id: ids) }
  scope :is_unread, -> { where(is_read: false) }
  scope :is_unsent, -> { where(is_sent: false) }
  scope :is_unread_and_unsent, -> { is_unread.is_unsent }

  scope :is_unread_and_unsent_for, ->(sender_id, recipient_id) {
    where(sender_id: sender_id, recipient_id: recipient_id).is_unread.is_unsent
  }

  def send_email
    NotificationMailer.notify(sender.email, recipient.email).deliver_now
  end

  def self.read_unread
    messages = Message.is_unread
    messages.update_all(is_read: true, is_sent: true)
  end

  def self.notify_about_unread
    messages = Message.is_unread_and_unsent
    message_ids = messages.ids
    messages.update_all(is_sent: true)
    Message.by_ids(message_ids).find_each { |message| message.send_email }
  end

  private

  def set_is_sent
    count = Message.is_unread_and_unsent_for(sender_id, recipient_id).count
    self.is_sent = true if count > 0
  end
end
