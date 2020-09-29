# frozen_string_literal: true

owner = FactoryBot.create(:owner, email: 'owner@example.com', password: 'password')
categories = FactoryBot.create_list(:category, 3)
FactoryBot.create_list(:house, 3, owner: owner, categories: categories)
FactoryBot.create_list(:house, 1, :deleted, owner: owner)

buyer = FactoryBot.create(:owner, email: 'buyer@example.com', password: 'password')
conversation = FactoryBot.create(:conversation, sender_id: buyer.id, recipient_id: owner.id)
FactoryBot.create(:message, sender_id: buyer.id, conversation_id: conversation.id)
FactoryBot.create(:message, sender_id: owner.id, conversation_id: conversation.id)
message = FactoryBot.create(:message, sender_id: buyer.id, conversation_id: conversation.id)
FactoryBot.create(:notification, :not_readed, message_id: message.id, recipient_id: owner.id)

FactoryBot.create(:owner, :admin, email: 'admin@example.com', password: 'password')
FactoryBot.create_list(:house, 15, categories: categories)
