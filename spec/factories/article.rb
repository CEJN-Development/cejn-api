# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body do
      ('i' * 20)
        .split('')
        .map { Faker::Lorem.paragraph(sentence_count: 10, random_sentences_to_add: 5) }
        .join("\n\n")
    end
    excerpt { Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 3) }
  end
end
