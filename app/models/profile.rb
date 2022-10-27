# frozen_string_literal: true

# top level documentation for Profile
class Profile < ApplicationRecord
  include IdentityMethods
  include FamilyMethods
  include FamilyTreeMethods

  has_one_attached :photo
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
                       notes parents_id category photo].freeze
  MAX_DEGREE_OF_SEPARATION = 10
  WITH_SELF_CAPTION = 'with self'

  validate :any_essential_info_present?
  validate :profile_with_same_designation?
  validate :forbidden_designation?
  validates :first_name_privacy,
            :last_name_privacy,
            :email_privacy,
            :phone_privacy,
            :birth_date_privacy,
            inclusion: { in: Profile::PRIVACIES }

  scope :designation_query, lambda { |value|
                              where("UNACCENT(profiles.first_name) ILIKE :query OR
                                UNACCENT(profiles.last_name) ILIKE :query OR
                                UNACCENT(profiles.email) ILIKE :query OR
                                UNACCENT(profiles.phone) ILIKE :query OR
                                UNACCENT(profiles.pseudo) ILIKE :query", query: "%#{I18n.transliterate(value)}%")
                            }

  # without family friend colleague
  scope :category_query, lambda { |value|
                           value == 'without' ? where(category: '') : where(category: value)
                         }

  # without with centenarian
  scope :birth_date_query, lambda { |value|
                             case value
                             when 'without'
                               where(birth_date: nil)
                             when 'with'
                               where.not(birth_date: nil)
                             when 'centenarian'
                               where('profiles.birth_date <= ?', 100.year.ago)
                             end
                           }

  def any_essential_info_present?
    return unless Profile::ESSENTIALS.all? { |attr| self[attr].blank? }

    errors.add :base, "Requiring at least one of those info: #{Profile::ESSENTIALS.map(&:humanize).to_sentence}"
  end

  def profile_with_same_designation?
    return unless Profile.where.not(id: id).where(creator_id: creator_id).map(&:designation).include?(designation)

    errors.add :base, "Another profile goes by the same designation: #{designation}"
  end

  # TODO
  def forbidden_designation?
    return unless [Profile::WITH_SELF_CAPTION].include?(designation)

    errors.add :base, "Forbidden designation, please change it: #{designation}"
  end

  def next_birthday
    date = Date.new(Time.zone.today.year, birth_date.month, birth_date.day)
    date.past? ? date + 1.year : date
  end

  def next_wedding_anniversary
    date = Date.new(Time.zone.today.year, wedding_date.month, wedding_date.day)
    date.past? ? date + 1.year : date
  end

  def partner_csv_designations
    ids = partner_ids
    designations = Profile.where(id: ids)
                          .map(&:designation)
    designations += [Profile::WITH_SELF_CAPTION] if ids.include?(nil)
    designations.join(';')
  end
end
