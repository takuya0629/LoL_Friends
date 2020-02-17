FactoryBot.define do
  factory :board do
    title { 'test' }
    content { 'test' }
    user { user }
  end
end