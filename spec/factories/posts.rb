FactoryBot.define do
  factory :post do
    title { "MyString" }
    pay { "9.99" }
    closed { false }
    description { "MyText" }
    start { 1 }
    owner { "MyString" }
  end
end
