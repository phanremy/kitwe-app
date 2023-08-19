# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation  # virtual attribute to skip password validation while saving

  has_many :couples, foreign_key: 'creator_id', dependent: :destroy
  has_many :profiles, foreign_key: 'creator_id', dependent: :destroy
  has_many :posts, dependent: :destroy

  after_create :create_own_profile

  def create_own_profile
    Profile.create(creator_id: id, email: email, pseudo: email.split('@').first)
  end

  protected

  def password_required?
    return false if skip_password_validation

    super
  end
end
