FactoryBot.define do
  factory :group do
    name { 'group1' }
    introduction { 'introduction1' }
    # インスタンスを渡さないといけない
    owner { owner }
  end
end