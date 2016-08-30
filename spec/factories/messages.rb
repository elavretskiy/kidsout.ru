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

require 'faker'

FactoryGirl.define do
  factory :message do
    association :sender, factory: :user
    association :recipient, factory: :user
    body { Faker::Lorem.sentence }
  end
end
