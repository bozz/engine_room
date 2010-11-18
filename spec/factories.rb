require 'factory_girl'

# By using the symbol ':user', we get Facory Firl to simulate the User model.
Factory.define :user do |user|
  user.username               "bsearles"
  user.email                  "bsearles@test.de"
  user.password               "foobar88"
  user.password_confirmation  "foobar88"
end

Factory.define :section do |section|
  section.model_name  "dog"
  section.sort_order  1
end

Factory.define :dog do |dog|
  dog.name            "Sigmund"
  dog.color           "golden"
  dog.description     "awesome"
  dog.fleas           13
end