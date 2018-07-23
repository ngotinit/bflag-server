Admin.create!(username: 'admin', password: 'admin')

Room.create!(name: 'General')
Room.create!(name: 'Hobby')
Room.create!(name: 'Education')
Room.create!(name: 'Entertainment')

User.create!(
  first_name: 'Quan',
  last_name: 'Nguyen',
  username: 'minhquan',
  email: 'quan@example.com',
  password: 'vinova123'
)

User.create!(
  first_name: 'Thien',
  last_name: 'Le',
  username: 'lethien',
  email: 'thien@example.com',
  password: 'vinova123'
)

User.create!(
  first_name: 'Quynh',
  last_name: 'Do',
  username: 'doquynh',
  email: 'quynh@example.com',
  password: 'vinova123'
)


