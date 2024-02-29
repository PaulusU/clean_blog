tags = ["Technology", "Sports", "Travel", "Foods", "Education"]
tags.each { |tag_name| Tag.create!(name: tag_name) }

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
  users.each { |user| user.blog_posts.create!(title: title, summary: summary, content: content) }
end

50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  summary = Faker::Lorem.sentence(word_count: 5)
  content = Faker::Lorem.sentence(word_count: 5)
  users.each do |user|
    blog_post = user.blog_posts.create!(title: title, summary: summary, content: content)
    # Assign random tags to the blog post
    random_tags = Tag.order("RANDOM()").limit(rand(3..5)) # Randomly select 3 to 5 tags
    blog_post.tags << random_tags
  end
end
