# frozen_string_literal: true

class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_confirmation_of :password
  has_many :houses
  has_many :notifications, foreign_key: 'recipient_id', dependent: :destroy
  has_many :recipient_conversations, foreign_key: 'recipient_id', class_name: 'Conversation'
  has_many :sender_conversations, foreign_key: 'sender_id', class_name: 'Conversation'

  validates :first_name, :last_name, :email, presence: true
  validates_uniqueness_of :email
end
