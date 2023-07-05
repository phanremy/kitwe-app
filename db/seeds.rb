# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

def profile_date
  random = (0..9).to_a
  date = Date.today
  random.sample.times do |_i|
    date += (random.sample.year * -1) + random.sample.month + random.sample.day + random.sample.hour
  end
  date
end

def random_privacy
  {
    first_name_privacy: %w[public only_shared only_friends private].sample,
    last_name_privacy: %w[public only_shared only_friends private].sample,
    email_privacy: %w[public only_shared only_friends private].sample,
    phone_privacy: %w[public only_shared only_friends private].sample,
    birth_date_privacy: %w[public only_shared only_friends private].sample,
    wedding_date_privacy: %w[public only_shared only_friends private].sample
  }
end

def random_info
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number_with_country_code ,
    birth_date: profile_date,
    wedding_date: profile_date
  }.merge(random_privacy)
end

puts 'Start Seed'

admin = User.find_or_create_by(email: 'user1@example.com') { |user| user.password = 'y3nUjm' }
User.find_or_create_by(email: 'user2@example.com') { |user| user.password = 'y3nUjm' }
visitor = User.find_or_create_by(email: 'user3@example.com') { |user| user.password = 'y3nUjm' }

# Post.create!(title: 'Visitor\'s first post', body: 'This is the first post of the visitor', user: visitor)
# Post.create!(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

if Profile.count.zero?
  date = profile_date

  Profile.create!(pseudo: nil,
                  creator_id: visitor.id,
                  first_name: 'Jean', first_name_privacy: 'public',
                  last_name: 'Chevalier', last_name_privacy: 'public',
                  email: 'jean.chevalier@example.com', email_privacy: 'public',
                  phone: '0123456', phone_privacy: 'public',
                  birth_date: date - 30.year, birth_date_privacy: 'public',
                  wedding_date: date, wedding_date_privacy: 'public',
                  address_privacy: 'public',
                  kids_privacy: 'public')

  jc = Profile.last
  Couple.create!(profile1_id: jc.id, profile2_id: nil, creator_id: visitor.id)

  Profile.create!(pseudo: 'anonymous',
                  creator_id: visitor.id,
                  first_name: 'Valentin', first_name_privacy: 'private',
                  last_name: 'Dupont', last_name_privacy: 'private',
                  email: nil, email_privacy: 'private',
                  phone: nil, phone_privacy: 'private',
                  birth_date: nil, birth_date_privacy: 'private',
                  wedding_date: nil, wedding_date_privacy: 'private',
                  address_privacy: 'private',
                  kids_privacy: 'private',
                  parents_id: Couple.first.id)

  anonymous = Profile.last

  date = profile_date

  Profile.create(pseudo: nil,
                 creator_id: visitor.id,
                 first_name: 'Julien', first_name_privacy: 'only_friends',
                 last_name: 'Alfonso', last_name_privacy: 'only_friends',
                 email: 'julien.alfonso@example.com', email_privacy: 'only_friends',
                 phone: '0123456', phone_privacy: 'public',
                 birth_date: date - 30.year, birth_date_privacy: 'public',
                 wedding_date: nil, wedding_date_privacy: 'only_friends',
                 address_privacy: 'only_friends',
                 kids_privacy: 'only_friends')

  ja = Profile.last
  Couple.create!(profile1_id: anonymous.id, profile2_id: ja.id, creator_id: visitor.id)

  date = profile_date
  Profile.create!(pseudo: 'WC',
                  creator_id: visitor.id,
                  first_name: 'William', first_name_privacy: 'only_friends',
                  last_name: 'Cloitre', last_name_privacy: 'only_friends',
                  email: 'william.cloitre@example.com', email_privacy: 'only_friends',
                  phone: nil, phone_privacy: 'private',
                  birth_date: nil, birth_date_privacy: 'private',
                  wedding_date: date, wedding_date_privacy: 'only_friends',
                  address_privacy: 'only_friends',
                  kids_privacy: 'only_friends',
                  parents_id: Couple.last.id)
end

if Profile.find_by(pseudo: 'papa').nil?
  pat_grand_pa = Profile.create!({ pseudo: 'Paternal Grand Ma', creator: admin }.merge(random_info))
  pat_grand_ma = Profile.create!({ pseudo: 'Paternal Grand Pa', creator: admin }.merge(random_info))
  pat_grand_parents = Couple.create!(
    profile1_id: pat_grand_pa.id, profile2_id: pat_grand_ma.id, creator_id: admin.id
  )

  mat_grand_pa = Profile.create!({ pseudo: 'Maternal Grand Ma', creator: admin }.merge(random_info))
  mat_grand_ma = Profile.create!({ pseudo: 'Maternal Grand Pa', creator: admin }.merge(random_info))
  mat_grand_parents = Couple.create!(
    profile1_id: mat_grand_pa.id, profile2_id: mat_grand_ma.id, creator_id: admin.id
  )

  dad = Profile.create!({ pseudo: 'Dad', parents_id: pat_grand_parents.id, creator: admin }.merge(random_info))
  mom = Profile.create!({ pseudo: 'Mom', parents_id: mat_grand_parents.id, creator: admin }.merge(random_info))
  parents = Couple.create!(
    profile1_id: dad.id, profile2_id: mom.id, creator_id: admin.id
  )

  mistress = Profile.create!({ pseudo: 'Mistress', creator: admin }.merge(random_info))
  affair = Couple.create!(
    profile1_id: dad.id, profile2_id: mistress.id, creator_id: admin.id
  )

  me = Profile.create!({ pseudo: 'Me', parents_id: parents.id, creator: admin }.merge(random_info))
  _sister = Profile.create!({ pseudo: 'Sister', parents_id: parents.id, creator: admin }.merge(random_info))
  _brother_in_law = Profile.create!({ pseudo: 'Brother in Law', parents_id: affair.id, creator: admin }.merge(random_info))

  pat_aunt = Profile.create!({ pseudo: 'Paternal Aunt', parents_id: pat_grand_parents.id, creator: admin }.merge(random_info))
  _mat_uncle = Profile.create!({ pseudo: 'Uncle', parents_id: mat_grand_parents.id, creator: admin }.merge(random_info))

  pat_aunt_bf = Profile.create!({ pseudo: 'Paternal Aunt Bf', creator: admin }.merge(random_info))
  pat_family = Couple.create!(
    profile1_id: pat_aunt.id, profile2_id: pat_aunt_bf.id, creator_id: admin.id
  )

  _cousin = Profile.create!({ pseudo: 'Cousin', parents_id: pat_family.id, creator: admin }.merge(random_info))

  bf_dad = Profile.create!({ pseudo: 'BF Dad', creator: admin }.merge(random_info))
  bf_mom = Profile.create!({ pseudo: 'BF Mom', creator: admin }.merge(random_info))
  bf_parents = Couple.create!(
    profile1_id: bf_dad.id, profile2_id: bf_mom.id, creator_id: admin.id
  )

  boyfriend = Profile.create!({ pseudo: 'boyfriend', parents_id: bf_parents.id, creator: admin }.merge(random_info))
  relation = Couple.create!(
    profile1_id: me.id, profile2_id: boyfriend.id, creator_id: admin.id
  )

  _adopted = Profile.create!({ pseudo: 'Adopted Daughter', parents_id: relation.id, creator: admin }.merge(random_info))
end

puts 'End Seed'
