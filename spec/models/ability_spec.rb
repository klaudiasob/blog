# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe 'Owner' do
    describe 'abilities' do
      subject(:ability) { described_class.new(owner) }

      let(:owner) { create(:owner) }

      context 'when owner is not an admin' do
        it 'assigns abilities to owner' do
          ability.should be_able_to(:manage, House.new(owner: owner))
          ability.should be_able_to(:show, House.new(owner: owner))
          ability.should be_able_to(:manage, owner)
          ability.should be_able_to(:manage, Conversation.new(sender_id: owner.id))
          ability.should be_able_to(:manage, Conversation.new(recipient_id: owner.id))
          ability.should_not be_able_to(:manage, House.new)
          ability.should_not be_able_to(:manage, Category.new)
        end
      end

      context 'when owner is an admin' do
        let(:owner) { create(:owner, admin: true) }

        it 'assigns abilities to admin' do
          ability.should be_able_to(:manage, House.new)
          ability.should be_able_to(:manage, Category.new)
        end
      end
    end
  end
end
