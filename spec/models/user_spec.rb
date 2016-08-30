# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @recipient = FactoryGirl.create(:user)
    @sender = FactoryGirl.create(:user)

    @body = Faker::Lorem.sentence
    @sender.send_message(@recipient, @body)
  end

  it 'send one message' do
    message = Message.find_by(recipient: @recipient, sender: @sender,
                              body: @body, is_read: false, is_sent: false)

    expect(message.present?).to eq true
  end

  it 'send two message' do
    body = Faker::Lorem.sentence
    @sender.send_message(@recipient, body)

    message = Message.find_by(recipient: @recipient, sender: @sender,
                              body: body, is_read: false, is_sent: true)

    expect(message.present?).to eq true
  end
end
