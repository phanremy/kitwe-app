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

admin = User.find_or_create_by(email: 'admin@example.com') { |user| user.password = 'password' }
visitor = User.find_or_create_by(email: 'visitor@example.com') { |user| user.password = 'password' }

Post.create!(title: 'Visitor\'s first post', body: 'This is the first post of the visitor', user: visitor)
Post.create!(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

if Profile.count.zero?
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

  jc = Profile.last
  Couple.create!(profile1_id: jc.id, profile2_id: nil, creator_id: admin.id)

  Profile.create!(pseudo: 'anonymous',
                  creator_id: admin.id,
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

  ja = Profile.last
  Couple.create!(profile1_id: anonymous.id, profile2_id: ja.id, creator_id: admin.id)

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
                  kids_privacy: 'only_friends',
                  parents_id: Couple.last.id)
end

if Profile.find_by(pseudo: 'papa').nil?
  pat_grand_pa = Profile.create!(pseudo: 'Paternal Grand Ma', creator: admin)
  pat_grand_ma = Profile.create!(pseudo: 'Paternal Grand Pa', creator: admin)
  pat_grand_parents = Couple.create!(
    profile1_id: pat_grand_pa.id, profile2_id: pat_grand_ma.id, creator_id: admin.id
  )

  mat_grand_pa = Profile.create!(pseudo: 'Maternal Grand Ma', creator: admin)
  mat_grand_ma = Profile.create!(pseudo: 'Maternal Grand Pa', creator: admin)
  mat_grand_parents = Couple.create!(
    profile1_id: mat_grand_pa.id, profile2_id: mat_grand_ma.id, creator_id: admin.id
  )

  dad = Profile.create!(pseudo: 'Dad', creator: admin, parents_id: pat_grand_parents.id)
  mom = Profile.create!(pseudo: 'Mom', creator: admin, parents_id: mat_grand_parents.id)
  parents = Couple.create!(
    profile1_id: dad.id, profile2_id: mom.id, creator_id: admin.id
  )

  mistress = Profile.create!(pseudo: 'Mistress', creator: admin)
  affair = Couple.create!(
    profile1_id: dad.id, profile2_id: mistress.id, creator_id: admin.id
  )

  me = Profile.create!(pseudo: 'Me', creator: admin, parents_id: parents.id)
  _sister = Profile.create!(pseudo: 'Sister', creator: admin, parents_id: parents.id)
  _brother_in_law = Profile.create!(pseudo: 'Brother in Law', creator: admin, parents_id: affair.id)

  pat_aunt = Profile.create!(pseudo: 'Paternal Aunt', creator: admin, parents_id: pat_grand_parents.id)
  _mat_uncle = Profile.create!(pseudo: 'Uncle', creator: admin, parents_id: mat_grand_parents.id)

  pat_aunt_bf = Profile.create!(pseudo: 'Paternal Aunt Bf', creator: admin)
  pat_family = Couple.create!(
    profile1_id: pat_aunt.id, profile2_id: pat_aunt_bf.id, creator_id: admin.id
  )

  _cousin = Profile.create!(pseudo: 'Cousin', creator: admin, parents_id: pat_family.id)

  bf_dad = Profile.create!(pseudo: 'BF Dad', creator: admin)
  bf_mom = Profile.create!(pseudo: 'BF Mom', creator: admin)
  bf_parents = Couple.create!(
    profile1_id: bf_dad.id, profile2_id: bf_mom.id, creator_id: admin.id
  )

  boyfriend = Profile.create!(pseudo: 'boyfriend', creator: admin, parents_id: bf_parents.id)
  relation = Couple.create!(
    profile1_id: me.id, profile2_id: boyfriend.id, creator_id: admin.id
  )

  _adopted = Profile.create!(pseudo: 'Adopted Daughter', creator: admin, parents_id: relation.id)
end

puts 'End Seed'
