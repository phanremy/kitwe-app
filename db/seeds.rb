# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def profile_date(number)
  Date.today - number.month - number.day
end

puts 'Start Seed'

admin = User.create(email: 'admin@example.com', password: 'password')
visitor = User.create(email: 'visitor@example.com', password: 'password')

Post.create!(title: 'Visitor\'s first post', body: 'This is the first post of the visitor', user: visitor)
Post.create!(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

profile_number = 1
date = profile_date(profile_number)

Profile.create!(pseudo: nil,
                creator_id: admin.id,
                first_name: 'Jean', first_name_privacy: 'public',
                last_name: 'Chevalier', last_name_privacy: 'public',
                email: 'jean.chevalier@example.com', email_privacy: 'public',
                phone: '0123456', phone_privacy: 'public',
                birth_date: date - 30.year, birth_date_privacy: 'public',
                wedding_date: date, wedding_date_privacy: 'public',
                address_privacy: 'public',
                kids_privacy: 'public')

profile_number += 1

Profile.create!(pseudo: 'anonymous',
                creator_id: admin.id,
                first_name: 'Valentin', first_name_privacy: 'private',
                last_name: 'Dupont', last_name_privacy: 'private',
                email: nil, email_privacy: 'private',
                phone: nil, phone_privacy: 'private',
                birth_date: nil, birth_date_privacy: 'private',
                wedding_date: nil, wedding_date_privacy: 'private',
                address_privacy: 'private',
                kids_privacy: 'private')

profile_number += 1
date = profile_date(profile_number)

Profile.create(pseudo: nil,
               creator_id: admin.id,
               first_name: 'Julien', first_name_privacy: 'only_friends',
               last_name: 'Alfonso', last_name_privacy: 'only_friends',
               email: 'julien.alfonso@example.com', email_privacy: 'only_friends',
               phone: '0123456', phone_privacy: 'public',
               birth_date: date - 30.year, birth_date_privacy: 'public',
               wedding_date: nil, wedding_date_privacy: 'only_friends',
               address_privacy: 'only_friends',
               kids_privacy: 'only_friends')

profile_number += 1
date = profile_date(profile_number)

Profile.create!(pseudo: 'WC',
                creator_id: admin.id,
                first_name: 'William', first_name_privacy: 'only_friends',
                last_name: 'Cloitre', last_name_privacy: 'only_friends',
                email: 'william.cloitre@example.com', email_privacy: 'only_friends',
                phone: nil, phone_privacy: 'private',
                birth_date: nil, birth_date_privacy: 'private',
                wedding_date: date, wedding_date_privacy: 'only_friends',
                address_privacy: 'only_friends',
                kids_privacy: 'only_friends')

puts 'End Seed'
