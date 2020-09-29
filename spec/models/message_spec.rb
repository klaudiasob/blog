require 'rails_helper'

RSpec.describe Message, :type => :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:conversation_id) }
    it { should validate_presence_of(:sender_id) }
  end

  describe 'associations' do
    it { should belong_to(:conversation).class_name('Conversation') }
    it { should belong_to(:sender).with_foreign_key('sender_id') }
    it { should have_many(:notifications).class_name('Notification') }
  end
end
