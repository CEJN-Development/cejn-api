# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :text
#  sample     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#  excerpt    :text
#
# Indexes
#
#  index_articles_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create :article }

  it 'is valid with valid attributes' do
    expect(article).to be_valid
  end

  it 'is not valid without a title' do
    article.title = nil
    expect(article).not_to be_valid
  end

  it 'is not valid without a body' do
    article.body = nil
    expect(article).not_to be_valid
  end

  it 'is not valid without an excerpt' do
    article.excerpt = nil
    expect(article).not_to be_valid
  end

  it 'slug is updated after save' do
    article.update! title: 'A Fancy New Title'
    expect(article.slug).to eq 'a-fancy-new-title'
  end

  it 'sample is body truncated at 600 character count' do
    article.update! body: Faker::Lorem.paragraph_by_chars(number: 1000)
    expect(article.body.length).to eq 1000
    expect(article.sample.length).to eq 603
  end
end
