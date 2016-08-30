require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '5s' do
  users = User.by_emails(['sitter@kidsout.ru', 'parent@kidsout.ru'])
  users.first.send_message(users.second, Faker::Lorem.sentence)
end

scheduler.every '10s' do
  users = User.by_emails(['sitter@kidsout.ru', 'parent@kidsout.ru'])
  users.second.send_message(users.first, Faker::Lorem.sentence)
end

scheduler.every '15s' do
  users = User.by_emails(['sitter@kidsout.ru', 'parent@kidsout.ru', 'test@kidsout.ru'])
  users.last.send_message(users.first, Faker::Lorem.sentence)
  users.last.send_message(users.second, Faker::Lorem.sentence)
end

scheduler.every '20s' do
  Message.notify_about_unread
end

scheduler.every '25s' do
  Message.read_unread
end
