FactoryBot.define do
  factory :user do
    id { 1 }
    email { "a@b.com" }
    password { "123456" }
  end
end
