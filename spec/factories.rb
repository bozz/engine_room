require 'factory_girl'

# By using the symbol ':user', we get Facory Firl to simulate the User model.
Factory.define :user do |user|
  user.username               "jdoe"
  user.email                  "jdoe@test.com"
  user.password               "foobar123"
  user.password_confirmation  "foobar123"
  user.is_admin               1
end

Factory.define :section do |section|
  section.name        "Dogs"
  section.model_name  "dog"
  section.sort_order  1
end

Factory.define :field do |field|
  field.column        "name"
  field.field_type    "text_field"
  field.sort_order    1
  field.display_type  "detail"
  field.help          "please fill in field."
  field.association :section
end

Factory.define :dog do |dog|
  dog.name            "Sigmund"
  dog.color           "golden"
  dog.description     "awesome"
  dog.fleas           13
end
