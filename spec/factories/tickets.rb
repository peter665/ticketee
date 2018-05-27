FactoryBot.define do
  factory :ticket do
    association :author, factory: :user
    name "MyString"
    description "MyStringggg"
    project nil
  end
end
