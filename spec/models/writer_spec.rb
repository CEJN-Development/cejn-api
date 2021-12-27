# frozen_string_literal: true

# == Schema Information
#
# Table name: writers
#
#  id                   :bigint           not null, primary key
#  full_name            :string           not null
#  slug                 :string           not null
#  byline               :text
#  cloudinary_image_url :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_writers_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe Writer, type: :model do
  let(:writer) { create :writer }

  it 'is valid with valid attributes' do
    expect(writer).to be_valid
  end

  it 'is not valid without a name' do
    writer.full_name = nil
    expect(writer).not_to be_valid
  end

  it 'is not valid without a byline' do
    writer.byline = nil
    expect(writer).not_to be_valid
  end

  it 'slug is updated after save' do
    writer.update! full_name: 'Jefferson Albert Tibbs'
    expect(writer.slug).to eq 'jefferson-albert-tibbs'
  end
end
