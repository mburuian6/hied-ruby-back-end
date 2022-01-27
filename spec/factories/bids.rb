FactoryBot.define do
  factory :bid do
    pay { "9.99" }
    notes { "MyText" }
    post { nil }
    owner { "MyString" }
  end
end
