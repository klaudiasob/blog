require 'rails_helper'

RSpec.describe Owner, :type => :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'associations' do
    it { should  have_many(:houses).class_name('House') }
    it { should  have_many(:notifications).with_foreign_key('recipient_id') }
    it { should  have_many(:recipient_conversations).with_foreign_key('recipient_id') }
    it { should  have_many(:sender_conversations).with_foreign_key('sender_id') }

  end

end