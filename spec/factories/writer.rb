# frozen_string_literal: true

FactoryBot.define do
  factory :writer do
    full_name { Faker::Name.name }
    byline { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
