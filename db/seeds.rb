10.times do |i|
User.create!(name: "test#{i + 1}",
             email: "seed#{i + 1}@example.jp",
             password: "password",
             password_confirmation: "password", 
             confirmed_at: DateTime.now)
end

5.times do |i|
Group.create!(name: "group-name#{i + 1 }",
             introduction: "introduction#{i + 1}",
             owner_id: User.find(i + 1).id
             )
end

5.times do |i|
Board.create!(title: "title#{i + 1 }",
             content: "content#{i + 1}",
             user_id: User.find(i + 1).id
             )
end