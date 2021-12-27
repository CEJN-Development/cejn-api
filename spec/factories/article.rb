# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 4) }
    excerpt { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
