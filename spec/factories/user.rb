FactoryBot.define do
  factory :admin_user, class: User do
    email {'my-example@myexample.com'}
    password {'goandtry123'}
    password_confirmation {'goandtry123'}
    admin_role {true}
  end
  20.times do |num|
    factory "normal_user_#{num}".to_sym, class: User do
      email {Faker::Internet.email}
      password {'goandtry123'}
      password_confirmation {'goandtry123'}
    end
  end
end
