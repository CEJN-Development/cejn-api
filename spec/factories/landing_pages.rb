# frozen_string_literal: true

FactoryBot.define do
  factory :landing_page do
    name { Faker::Creature::Animal.name }
    preview { Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 3) }
    body do
      3.times
       .map { Faker::Lorem.paragraph(sentence_count: 10, random_sentences_to_add: 5) }
       .join("\n\n")
    end
  end
end
