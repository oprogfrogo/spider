# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

agents = Agent.create([
  {
    login: 'kosho',
    password: 'sdfsdf',
    name: 'Kosho Watanabe',
    email: 'oprogfrogo@gmail.com',
    phone: '888-888-8888',
    ext: nil,
    round_robin: 0
  },
  {
    login: 'simon',
    password: 'sdfsdf',
    name: 'Simon Lee',
    email: 'oprogfrogo@gmail.com',
    phone: '888-888-8888',
    ext: nil,
    round_robin: 0
  }
])

quotes = Quote.create([
  {
    kind: 'home',
    promo: 'june_2016',
    level: 'bronze',
    price: '100'
  },
  {
    kind: 'home',
    promo: 'june_2016',
    level: 'silver',
    price: '200'
  },
  {
    kind: 'home',
    promo: 'june_2016',
    level: 'gold',
    price: '300'
  }
])
