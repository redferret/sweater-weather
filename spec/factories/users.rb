FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { 'password' }
    api_key { SecureRandom.urlsafe_base64 }
  end
end
