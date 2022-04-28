# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::Book.title }
    body do
      ('i' * 20)
        .split('')
        .map { Faker::Lorem.paragraph(sentence_count: 10, random_sentences_to_add: 5) }
        .join("\n\n")
    end
    date { Time.utc(Faker::Date.forward(days: 10).to_s).in_time_zone.to_s }
    description { Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 2) }
  end
end
