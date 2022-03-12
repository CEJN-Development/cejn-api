# == Schema Information
#
# Table name: press_releases
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  slug       :string           not null
#  body       :text
#  summary    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_press_releases_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe PressRelease, type: :model do
  let(:press_release) { create :press_release }

  it 'is valid with valid attributes' do
    expect(press_release).to be_valid
  end

  it 'is not valid without a title' do
    press_release.title = nil
    expect(press_release).not_to be_valid
  end

  it 'is not valid without a body' do
    press_release.body = nil
    expect(press_release).not_to be_valid
  end

  it 'is not valid without an summary' do
    press_release.summary = nil
    expect(press_release).not_to be_valid
  end

  it 'slug is updated after save' do
    press_release.update! title: 'A Fancy New Title'
    expect(press_release.slug).to eq 'a-fancy-new-title'
  end
end
