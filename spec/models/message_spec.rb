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

require 'rails_helper'

RSpec.describe Message, type: :model do
  before(:each) do
    @recipient = FactoryGirl.create(:user)
    @sender = FactoryGirl.create(:user)

    @body = Faker::Lorem.sentence
    @sender.send_message(@recipient, @body)
  end

  it 'read unread' do
    Message.read_unread

    message = Message.find_by(recipient: @recipient, sender: @sender,
                              body: @body, is_read: true, is_sent: true)

    expect(message.present?).to eq true
  end

  it 'notify about unread' do
    user = FactoryGirl.create(:user)
    user.send_message(@recipient, @body)

    Message.notify_about_unread

    message = Message.find_by(recipient: @recipient, sender: @sender,
                              body: @body, is_read: false, is_sent: true)

    expect(message.present?).to eq true
    expect(ActionMailer::Base.deliveries.count).to eq 2
  end
end
