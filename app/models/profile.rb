# frozen_string_literal: true

# top level documentation for Profile
class Profile < ApplicationRecord
  # has_paper_trail

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :user, optional: true
  belongs_to :parents, class_name: 'Couple', foreign_key: 'parents_id', optional: true

  has_many :couples1, class_name: 'Couple', foreign_key: :profile1_id,
                      dependent: :nullify, inverse_of: :profile1
  has_many :couples2, class_name: 'Couple', foreign_key: :profile2_id,
                      dependent: :nullify, inverse_of: :profile2

  # has_many :profile_events,           dependent: :delete_all
  # has_many :events,                   inverse_of: :profiles, through: :profile_events

  PRIVACIES = %w[public only_shared only_friends private].freeze
  ESSENTIALS = %w[pseudo first_name last_name email phone].freeze
  FORM_ATTRIBUTES = %w[creator_id pseudo first_name first_name_privacy last_name last_name_privacy email email_privacy
                       phone phone_privacy birth_date birth_date_privacy tiktok_url twitter_url linkedin_url
                       notes parents_id].freeze

  validate :any_essential_info_present?
  validate :profile_with_same_designation?
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

  def profile_with_same_designation?
    return unless Profile.where.not(id: id).where(creator_id: creator_id).map(&:designation).include?(designation)

    errors.add :base, "Another profile goes by the same designation: #{designation}"
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def designation
    option_bis = email.present? ? email : phone
    option = full_name.present? ? full_name : option_bis
    pseudo.present? ? pseudo : option
  end

  def couples
    [couples1, couples2].flatten
  end

  def partner_ids
    [
      Couple.where(profile1_id: self).pluck(:profile2_id),
      Couple.where(profile2_id: self).pluck(:profile1_id)
    ].flatten
  end

  def parents_profiles
    couple = parents
    return nil if couple.nil?

    Profile.where(id: [couple.profile1_id, couple.profile2_id])
  end

  def children_profiles
    couples.map(&:children).flatten
  end

  def close_family
    ids = [id, partner_ids, parents_profiles&.pluck(:id), children_profiles&.pluck(:id)].flatten
    Profile.where(id: ids)
  end

  def next_birthday
    date = Date.new(Time.zone.today.year, birth_date.month, birth_date.day)
    date.past? ? date + 1.year : date
  end

  def next_wedding_anniversary
    date = Date.new(Time.zone.today.year, wedding_date.month, wedding_date.day)
    date.past? ? date + 1.year : date
  end
end
