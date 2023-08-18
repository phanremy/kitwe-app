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

def random_info
  {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number_with_country_code ,
    birth_date: profile_date,
    wedding_date: profile_date
  }
end

puts 'Start Seed'

admin = User.find_or_create_by(email: 'user1@example.com') { |user| user.password = 'password' }
User.find_or_create_by(email: 'user2@example.com') { |user| user.password = 'password' }
visitor = User.find_or_create_by(email: 'user3@example.com') { |user| user.password = 'password' }

# Post.create!(title: 'Visitor\'s first post', body: 'This is the first post of the visitor', user: visitor)
# Post.create!(title: 'Admin\'s first post', body: 'This is the first post of the admin', user: admin)

if Profile.find_by(first_name: 'Jean').nil?
  date = profile_date

  Profile.create!(pseudo: nil, creator_id: visitor.id, gender: 'male',
                  first_name: 'Jean',
                  last_name: 'Chevalier',
                  email: 'jean.chevalier@example.com',
                  phone: '0123456',
                  birth_date: date - 30.year,
                  death_date: date + 30.year,
                  wedding_date: date)

  jc = Profile.last
  Couple.create!(profile1_id: jc.id, profile2_id: nil, creator_id: visitor.id, status: 'in_a_relationship')

  Profile.create!(pseudo: 'anonymous', creator_id: visitor.id, gender: 'female',
                  first_name: 'Valentin',
                  last_name: 'Dupont',
                  email: nil,
                  phone: nil,
                  birth_date: nil,
                  wedding_date: nil,
                  parents_id: Couple.first.id)

  anonymous = Profile.last

  date = profile_date

  Profile.create(pseudo: nil, creator_id: visitor.id, gender: 'male',
                 first_name: 'Julien',
                 last_name: 'Alfonso',
                 email: 'julien.alfonso@example.com',
                 phone: '0123456',
                 birth_date: date - 30.year,
                 wedding_date: nil)

  ja = Profile.last
  Couple.create!(profile1_id: anonymous.id, profile2_id: ja.id, creator_id: visitor.id, status: 'separated')

  date = profile_date
  Profile.create!(pseudo: 'WC', creator_id: visitor.id, gender: 'male',
                  first_name: 'William',
                  last_name: 'Cloitre',
                  email: 'william.cloitre@example.com',
                  phone: nil,
                  birth_date: nil,
                  wedding_date: date,
                  parents_id: Couple.last.id)
end

if Profile.find_by(pseudo: 'Paternal Grand Ma').nil?
  pat_grand_pa = Profile.create!({ pseudo: 'Paternal Grand Ma', creator: admin, gender: 'female' }.merge(random_info))
  pat_grand_ma = Profile.create!({ pseudo: 'Paternal Grand Pa', creator: admin, gender: 'male' }.merge(random_info))
  pat_grand_parents = Couple.create!(
    profile1_id: pat_grand_pa.id, profile2_id: pat_grand_ma.id, creator_id: admin.id
  )

  mat_grand_pa = Profile.create!({ pseudo: 'Maternal Grand Ma', creator: admin, gender: 'female' }.merge(random_info))
  mat_grand_ma = Profile.create!({ pseudo: 'Maternal Grand Pa', creator: admin, gender: 'male' }.merge(random_info))
  mat_grand_parents = Couple.create!(
    profile1_id: mat_grand_pa.id, profile2_id: mat_grand_ma.id, creator_id: admin.id
  )

  mom = Profile.create!(
    { pseudo: 'Mom', parents_id: mat_grand_parents.id, creator: admin, gender: 'female' }.merge(random_info)
  )
  dad = Profile.create!(
    { pseudo: 'Dad', parents_id: pat_grand_parents.id, creator: admin, gender: 'male' }.merge(random_info)
  )
  parents = Couple.create!(
    profile1_id: dad.id, profile2_id: mom.id, creator_id: admin.id
  )

  mistress = Profile.create!({ pseudo: 'Mistress', creator: admin, gender: 'female' }.merge(random_info))
  affair = Couple.create!(
    profile1_id: dad.id, profile2_id: mistress.id, creator_id: admin.id
  )

  me = Profile.create!(
    { pseudo: 'Me', parents_id: parents.id, creator: admin, gender: 'female' }.merge(random_info)
  )
  _sister = Profile.create!(
    { pseudo: 'Sister', parents_id: parents.id, creator: admin, gender: 'female' }.merge(random_info)
  )
  _brother_in_law = Profile.create!(
    { pseudo: 'Brother in Law', parents_id: affair.id, creator: admin, gender: 'male' }.merge(random_info)
  )

  pat_aunt = Profile.create!(
    { pseudo: 'Paternal Aunt', parents_id: pat_grand_parents.id, creator: admin, gender: 'female' }.merge(random_info)
  )
  _mat_uncle = Profile.create!(
    { pseudo: 'Uncle', parents_id: mat_grand_parents.id, creator: admin, gender: 'male' }.merge(random_info)
  )

  pat_aunt_bf = Profile.create!(
    { pseudo: 'Paternal Aunt Bf', creator: admin, gender: 'male' }.merge(random_info)
  )
  pat_family = Couple.create!(
    profile1_id: pat_aunt.id, profile2_id: pat_aunt_bf.id, creator_id: admin.id
  )

  _cousin = Profile.create!(
    { pseudo: 'Cousin', parents_id: pat_family.id, creator: admin, gender: 'male' }.merge(random_info)
  )

  bf_dad = Profile.create!(
    { pseudo: 'BF\'s Dad', creator: admin, gender: 'male' }.merge(random_info)
  )
  bf_mom = Profile.create!(
    { pseudo: 'BF\'s Mom', creator: admin, gender: 'female' }.merge(random_info)
  )
  bf_parents = Couple.create!(
    profile1_id: bf_dad.id, profile2_id: bf_mom.id, creator_id: admin.id
  )

  boyfriend = Profile.create!(
    { pseudo: 'Boyfriend', parents_id: bf_parents.id, creator: admin, gender: 'male' }.merge(random_info)
  )
  relation = Couple.create!(
    profile1_id: me.id, profile2_id: boyfriend.id, creator_id: admin.id
  )

  _adopted = Profile.create!(
    { pseudo: 'Adopted Daughter', parents_id: relation.id, creator: admin, gender: 'female' }.merge(random_info)
  )
end

puts 'End Seed'
