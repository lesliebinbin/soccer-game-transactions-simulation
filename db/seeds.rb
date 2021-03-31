%w[lesliebinbin19900129@gmail.com huangzhibin11@live.com].each do |email|
  User.create(email: email, password: 'Woainvren1', password_confirmation: 'Woainvren1')
end
