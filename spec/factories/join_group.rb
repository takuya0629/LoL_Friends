FactoryBot.define do
  factory :join_group do
    user_id { user }
    group_id { group }
  end
end