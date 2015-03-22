# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ConfigTable.create(key: 'total_time', value: 1800)
ConfigTable.create(key: 'correct_marks', value: 4)
ConfigTable.create(key: 'incorrect_marks', value: 1)
ConfigTable.create(key: 'start_time', value: nil)
