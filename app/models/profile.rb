# frozen_string_literal: true

# top level documentation for Profile
class Profile < ApplicationRecord
  # has_paper_trail

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :user, optional: true

  belongs_to :parents, class_name: 'Couple', foreign_key: 'parents_id'

  # has_many :profile_events,           dependent: :delete_all
  # has_many :events,                   inverse_of: :profiles, through: :profile_events

  PRIVACIES = %w[public only_shared only_friends private].freeze
  ESSENTIALS = %w[pseudo first_name last_name email phone].freeze
  FORM_ATTRIBUTES = %w[creator_id pseudo first_name first_name_privacy last_name last_name_privacy email email_privacy
                       phone phone_privacy birth_date birth_date_privacy tiktok_url twitter_url linkedin_url
                       notes].freeze

  validate :any_essential_info_present?
  validates :first_name_privacy,
            :last_name_privacy,
            :email_privacy,
            :phone_privacy,
            :birth_date_privacy,
            inclusion: { in: Profile::PRIVACIES }

  def any_essential_info_present?
    return unless Profile::ESSENTIALS.all? { |attr| self[attr].blank? }

    errors.add :base, "Requiring at least one of those info: #{Profile::ESSENTIALS.map(&:humanize).to_sentence}"
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def designation
    option_bis = email.present? ? email : phone
    option = full_name.present? ? full_name : option_bis
    pseudo.present? ? pseudo : option
  end

  def next_birthday
    date = Date.new(Time.zone.today.year, birth_date.month, birth_date.day)
    date.past? ? date + 1.year : date
  end
end
