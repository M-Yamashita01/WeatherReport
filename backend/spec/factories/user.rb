FactoryBot.define do
  factory :user, class: User do
    email { 'test@test.com' }
    password { 'password' }
  end

  factory :test_user, class: User do
    email { 'test_user@test.com' }
    password { 'testpass' }
  end
end
