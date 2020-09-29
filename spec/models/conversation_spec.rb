require 'rails_helper'

RSpec.describe Conversation, :type => :model do
  describe 'validations' do
    it { should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }
  end


  describe 'associations' do
    it { should  belong_to(:sender).with_foreign_key('sender_id') }
    it { should  belong_to(:recipient).with_foreign_key('recipient_id') }
    it { should  have_many(:messages).class_name('Message') }
  end

  end