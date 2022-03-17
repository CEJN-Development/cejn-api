# frozen_string_literal: true

FactoryBot.define do
  factory :organization do
    name { Faker::Name.name }
    blurb { Faker::Lorem.paragraph(sentence_count: 4) }
    body { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
