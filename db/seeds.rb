Admin.create!(username: 'admin', password: 'admin')

Room.create!(name: 'General')
Room.create!(name: 'Hobby')
Room.create!(name: 'Education')
Room.create!(name: 'Entertainment')

User.create!(
  first_name: 'Quan',
  last_name: 'Nguyen',
  username: 'minhquan',
  email: 'minhquan190597@gmail.com',
  password: 'vinova123'
)

User.create!(
  first_name: 'Thien',
  last_name: 'Le',
  username: 'lethien',
  email: 'leanhthienhcmut@gmail.com',
  password: 'vinova123'
)

User.create!(
  first_name: 'Quynh',
  last_name: 'Do',
  username: 'doquynh',
  email: 'quynhdx0305@gmail.com',
  password: 'vinova123'
)
