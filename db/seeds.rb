# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

agents = Agent.create([
  {
    login: 'agent',
    password: '123456',
    name: 'Spider Policy Agent',
    email: 'oprogfrogo@gmail.com',
    phone: '888-888-8888',
    ext: nil,
    round_robin: 1
  }
])

quotes = Quote.create([
  {
    kind: 'home',
    promo_date: '2017-06-01',
    category: 'bronze',
    carrier: 'Tokio Marine USA',
    bodily_injury_liability: '$15,000 / PP   $30,000 / OCC',
    property_damage_liability: '$10,000',
    medical_payments: '$1,000',
    uninsured_motorist_bodily_injury: '$15,000 / PP  $30,000 / OCC',
    comprehensive: 'Not Included',
    collision: 'Not Included',
    waiver_of_collision_deductible: '$3,500',
    rental_reimbursement: 'Not Included',
    roadside_coverage: 'Not Included',
    total_premium: '$200 / Month'
  },
  {
    kind: 'home',
    promo_date: '2017-06-01',
    category: 'silver',
    carrier: 'Tokio Marine USA',
    bodily_injury_liability: '$50,000 / PP  $100,000 / OCC',
    property_damage_liability: '$50,000',
    medical_payments: '$2,000',
    uninsured_motorist_bodily_injury: '$50,000 / PP  $100,000 / OCC',
    comprehensive: '$500',
    collision: '$500',
    waiver_of_collision_deductible: 'Included',
    rental_reimbursement: '$30 day for 30 days',
    roadside_coverage: 'Included',
    total_premium: '$400 / Month'
  },
  {
    kind: 'home',
    promo_date: '2017-06-01',
    category: 'gold',
    carrier: 'Tokio Marine USA',
    bodily_injury_liability: '$100,000 / PP  $300,000 /OCC',
    property_damage_liability: '$100,000',
    medical_payments: '$5,000',
    uninsured_motorist_bodily_injury: '$100,000 / PP  $300,000 / OCC',
    comprehensive: '$500',
    collision: '$500',
    waiver_of_collision_deductible: 'Included',
    rental_reimbursement: '$40 day for 30 days',
    roadside_coverage: 'Included',
    total_premium: '$600 / Month'
  }
])
