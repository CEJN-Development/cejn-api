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
    date { Faker::Time.forward(days: 10) }
    description { Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 2) }
  end
end
