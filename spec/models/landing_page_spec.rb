# == Schema Information
#
# Table name: landing_pages
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  preview    :text
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_landing_pages_on_slug  (slug)
#
require 'rails_helper'

RSpec.describe LandingPage, type: :model do
  let(:landing_page) { create :landing_page }

  it 'is valid with valid attributes' do
    expect(landing_page).to be_valid
  end

  it 'is not valid without a name' do
    landing_page.name = nil
    expect(landing_page).not_to be_valid
  end

  it 'is not valid without a preview' do
    landing_page.preview = nil
    expect(landing_page).not_to be_valid
  end

  it 'is not valid without a body' do
    landing_page.body = nil
    expect(landing_page).not_to be_valid
  end

  context 'when a record exists' do
    let!(:landing_page) { create :landing_page }

    it 'is not valid if another record has same name' do
      new_landing_page = LandingPage.new(name: landing_page.name, preview: "blah", body: "blah blah")
      expect(new_landing_page).not_to be_valid
    end

    it 'can save if the name value is unique' do
      new_landing_page = LandingPage.new(name: 'New Section', preview: "blah", body: "blah blah")
      expect(new_landing_page).to be_valid
    end
  end
end
