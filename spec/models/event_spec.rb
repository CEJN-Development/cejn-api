# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                   :bigint           not null, primary key
#  date                 :datetime         not null
#  cloudinary_image_url :string
#  name                 :string           not null
#  slug                 :string
#  body                 :text
#  description          :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_events_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create :event }

  it 'is valid with valid attributes' do
    expect(event).to be_valid
  end

  it 'is not valid without a name' do
    event.name = nil
    expect(event).not_to be_valid
  end

  it 'is not valid without a date' do
    event.date = nil
    expect(event).not_to be_valid
  end

  it 'is not valid without a body' do
    event.body = nil
    expect(event).not_to be_valid
  end

  it 'is not valid without a description' do
    event.description = nil
    expect(event).not_to be_valid
  end
end
