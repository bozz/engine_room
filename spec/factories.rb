require 'factory_girl'

# By using the symbol ':user', we get Facory Firl to simulate the User model.
Factory.define :user do |user|
  user.username               "Boris Searles"
  user.email                  "bsearles@test.de"
  user.password               "foobar88"
  user.password_confirmation  "foobar88"
end