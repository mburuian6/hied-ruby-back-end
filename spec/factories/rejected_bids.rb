FactoryBot.define do
  factory :rejected_bid do
    pay { "9.99" }
    notes { "MyText" }
    post { nil }
    owner { "MyString" }
  end
end
