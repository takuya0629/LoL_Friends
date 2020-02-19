FactoryBot.define do
  factory :group do
    name { 'group1' }
    introduction { 'introduction1' }
    # インスタンスを渡さないといけない
    owner { owner }
  end

  factory :approval_group, class: Group do
    name { 'approval_group' }
    introduction { 'introduction1' }
    approval_system { true }
    owner { owner }
  end
end