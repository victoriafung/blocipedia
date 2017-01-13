# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'random_data'

wikis = Wiki.all

  admin = User.create!(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
  )

  standard = User.create!(
    name:     'standard User',
    email:    'standard@example.com',
    password: 'standard'
    role: 'standard'
  )

  premium = User.create!(
    name:     'premium User',
    email:    'premium@example.com',
    password: 'premium',
    role: 'premium'
  )

  20.times do
    Wiki.create!(
      title:  RandomData.random_word,
      body:   RandomData.random_paragraph,
      user_id: User.first.id
    )
  end

 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
