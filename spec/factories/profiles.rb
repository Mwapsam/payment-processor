FactoryBot.define do
  factory :profile do
    full_name { "MyString" }
    address { "MyString" }
    phone_number { "MyString" }
    email { "MyString" }
    tpin { "MyString" }
    business_name { "MyString" }
    user { nil }
  end
end
