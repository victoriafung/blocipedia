# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

  10.times do
    user = User.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Lorem.words(6)
    )
    user.save!
  end

    User.create!(
      name:     'Admin User',
      email:    'admin@example.com',
      password: 'adminadmin',
      role: 'admin'
    )

    User.create!(
      name:     'Premium User',
      email:    'premium@example.com',
      password: 'premium',
      role:     'premium'
    )

    User.create!(
      name:     'Standard User',
      email:    'standard@example.com',
      password: 'standard',
      role:     'standard'
    )

  users = User.all

  30.times do
    wiki = Wiki.new(
      title:  Faker::Superhero.name,
      body:   Faker::Hipster.paragraphs,
      user:   users.sample,
      private: Faker::Boolean.boolean
    )
    wiki.save!
  end

  wikis = Wiki.all

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
