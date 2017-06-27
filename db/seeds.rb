Agent.create([
  {
    login: 'simon',
    password: 'sdfsdf',
    name: 'Simon Lee',
    email: 'oprogfrogo@gmail.com',
    phone: '310-951-5044',
    ext: nil,
    round_robin: 1
  }
])

User.create([
  {
    fullname: 'Simon Lee'
    email: 'oprogfrogo@gmail.com',
    password: 'sdfsdf',
    token: 'Simon Lee',
    confirmed: 'Y'
  }
])

Auto.create([
  {
    user_id: 1,
    vin: '123123',
    year: '2017',
    make: 'Toyota',
    model: 'Camry',
    status: 'pending',
    token: 'd5c09355-0d2f-44e2-be00-06f3ce9d8385'
  }
])

Home.create([
  {
    user_id: 1,
    street: '111 Test St.',
    street2: '',
    city: 'Los Angeles',
    state: 'CA',
    postal_code: '90066',
    year_built: '2016',
    alarm_system: 'Y',
    status: 'pending'
  }
])

QuotesAuto.create([
  {
    auto_id: 1,
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
    auto_id: 1,
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
    auto_id: 1,
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

QuotesHome.create([
  {
    home_id: 1,
    dwelling_limit: '',
    dwelling_premium: '',
    personal_property_limit: '',
    personal_property_premium: '',
    loss_of_use_limit: '',
    loss_of_use_premium: '',
    liability_limit: '',
    liability_premium: '',
    medical_payments_limit: '',
    medical_payments_premium: '',
    deductible_limit: '',
    deductible_premium: '',
    premises_alarm_fire_system_limit: '',
    premises_alarm_fire_system_premium: '',
    contents_other_residents_limit: '',
    contents_other_residents_premium: '',
    unscheduled_personal_property_limit: '',
    unscheduled_personal_property_premium: '',
    jewels_watches_furs_limit: '',
    jewels_watches_furs_premium: '',
    money_limit: '',
    money_premium: '',
    securities_limit: '',
    securities_premium: '',
    silver_gold_pewter_limit: '',
    silver_gold_pewter_premium: '',
    firearms_limit: '',
    firearms_premium: '',
    electronic_app_vehicles_limit: '',
    electronic_app_vehicles_premium: '',
    electronic_app_business_limit: '',
    electronic_app_business_premium: '',
    workers_compensation_limit: '',
    workers_compensation_premium: '',
    inflation_guard_limit: '',
    inflation_guard_premium: '',
    ordinance_or_law_converage_limit: '',
    ordinance_or_law_converage_premium: '',
    replace_cost_contents_limit: '',
    replace_cost_contents_premium: '',
    fungi_mold_bacteria_limit: '',
    fungi_mold_bacteria_premium: '',
    total_premium_limit: '',
    total_premium_premium: ''
  }
])
