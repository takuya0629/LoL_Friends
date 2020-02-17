FactoryBot.define do
  factory :user do
    name { 'test_1' }
    email { 'test1@aa.aa' }
    password { 'testtesttest' }
    confirmed_at { DateTime.now }
  end

  factory :user2, class: User do
    name { 'test_2' }
    email { 'test2@aa.aa' }
    password { 'testtesttest2' }
    confirmed_at { DateTime.now }
  end
end