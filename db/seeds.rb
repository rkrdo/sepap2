# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.attr_accessible :teacher, :admin, :name, :lastname
User.create(name: "Admin", lastname: "Super", email: "admin@sepap.com", password: "121212", password_confirmation: "121212", num: "A12121212", teacher: true, admin: true)
User.create(name: "Luis", lastname: "Gonzalez", email: "L00904961@itesm.mx", password: "121212", password_confirmation: "121212", num: "L00904961", teacher: true, admin: true)
User.create(name: "Armandina", lastname: "Leal", email: "L00163642@itesm.mx", password: "121212", password_confirmation: "121212", num: "L00163642", teacher: true, admin: true)

Command.create(name: "C", compile_command: "gcc -o %s %s.c", run_command: "%sMain",  description: "placeholders for executable and sourcecode")
Command.create(name: "CPP", compile_command: "g++ -x c++ -o %s %s.cpp", run_command: "%sMain", description: "placeholders for executable and sourcecode")
Command.create(name: "CS", compile_command: "gmcs -out:%s.exe %s.cs", run_command: "mono %sMain%s", run_extension: ".exe", description: "mono")
Command.create(name: "JAVA", compile_command: "javac %s.java", run_command: "java -classpath %s Main", description: "open jdk java 7 runtime")
