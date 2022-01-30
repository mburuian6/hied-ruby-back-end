FactoryBot.define do
  factory :accepted_bid do
    pay { "9.99" }
    notes { "MyText" }
    post { nil }
    owner { "MyString" }
  end
end
