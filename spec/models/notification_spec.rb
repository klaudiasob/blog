require 'rails_helper'

RSpec.describe Notification, :type => :model do
  describe 'validations' do
    it { should validate_presence_of(:recipient_id) }
    it { should validate_presence_of(:message_id) }
  end

  describe 'associations' do
    it { should belong_to(:message).class_name('Message') }
    it { should belong_to(:recipient).with_foreign_key('recipient_id') }
  end
end