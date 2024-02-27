User.create!(name:  "Admin Blog", 
             email: "blog@example.org", 
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.unique.email # Use Faker's unique method to generate unique email addresses
  password = "password" 
  User.create!(name: name, 
               email: email,  
               password: password,
               password_confirmation: password,)
end

users = User.order(:created_at).take(6)

50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  summary = Faker::Lorem.sentence(word_count: 5)
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.blog_post.create!(title: title, summary: summary, content: content) }
end