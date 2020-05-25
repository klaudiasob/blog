# frozen_string_literal: true

class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates_confirmation_of :password
  has_many :houses
  has_many :notifications, dependent: :destroy

  validates :first_name, :last_name, :email, presence: true
end
