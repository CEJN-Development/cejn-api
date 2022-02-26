# == Schema Information
#
# Table name: splash_sections
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  priority   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe SplashSection, type: :model do
  let(:splash_section) { create :splash_section }

  it 'is valid with valid attributes' do
    expect(splash_section).to be_valid
  end

  it 'is not valid without a name' do
    splash_section.name = nil
    expect(splash_section).not_to be_valid
  end

  it 'is not valid without a priority' do
    splash_section.priority = nil
    expect(splash_section).not_to be_valid
  end

  context 'when a record exists' do
    let!(:splash_section) { create :splash_section, priority: 1 }

    it 'is not valid if another section has same priority' do
      new_splash_section = SplashSection.new(name: 'New Section', priority: 1)
      expect(new_splash_section).not_to be_valid
    end

    it 'is not valid if another section has same name' do
      new_splash_section = SplashSection.new(name: splash_section.name, priority: splash_section.priority + 1)
      expect(new_splash_section).not_to be_valid
    end

    it 'can save if the values are unique' do
      new_splash_section = SplashSection.new(name: 'New Section', priority: splash_section.priority + 1)
      expect(new_splash_section).to be_valid
    end
  end
end
