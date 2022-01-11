# frozen_string_literal: true

FactoryBot.define do
  factory :splash_section do
    name { Faker::Creature::Animal.name }
    priority { Faker::Number.within(range: 1..10) }
  end
end
