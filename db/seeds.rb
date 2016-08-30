emails = ['parent@kidsout.ru', 'sitter@kidsout.ru', 'test@kidsout.ru']
emails.each { |email| User.find_or_create_by!(email: email) }
