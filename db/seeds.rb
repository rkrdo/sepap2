# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.attr_accessible :teacher, :admin
User.create(email: "admin@sepap.com", password: "121212", password_confirmation: "121212", num: "A12121212", teacher: true, admin: true)
User.create(email: "L00904961@itesm.mx", password: "121212", password_confirmation: "121212", num: "L00904961", teacher: true, admin: true)
User.create(email: "L00163642@itesm.mx", password: "121212", password_confirmation: "121212", num: "L00163642", teacher: true, admin: true)
