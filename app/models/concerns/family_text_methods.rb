# frozen_string_literal: true

module FamilyTextMethods
  extend ActiveSupport::Concern

  def idh
    ['#', id].join
  end

  def full_family_text_description
    return nil unless id.present?

    full_family.map do |profile|
      "#{profile.idh} is: #{profile.text_description.join(' ')}"
    end.join('. ')
  end

  def text_description
    result = []
    index = 1
    profile_data.each do |data|
      next unless data[:profiles].any?

      result.push(" #{index}- the #{data[:description]} of #{data[:profiles].map(&:idh).to_sentence}")
      index += 1
    end
    result.push("#{index}- in a relationship with #{couples_ids.to_sentence}") if couples.present?
    result
  end

  private

  def couples_ids
    couples.map { |couple| couple.other_partner(self)&.idh }
  end

  def profile_data
    @profile_data ||=
      [
        { description: child_description, profiles: parents_profiles },
        { description: sibling_description, profiles: sibling_profiles },
        { description: parent_description, profiles: children_profiles }
      ]
  end

  def child_description
    case gender
    when 'male'
      I18n.t('son', scope: scope)
    when 'female'
      I18n.t('daughter', scope: scope)
    else
      I18n.t('child', scope: scope)
    end
  end

  def sibling_description
    case gender
    when 'male'
      I18n.t('brother', scope: scope)
    when 'female'
      I18n.t('sister', scope: scope)
    else
      I18n.t('sibling', scope: scope)
    end
  end

  def parent_description
    case gender
    when 'male'
      I18n.t('father', scope: scope)
    when 'female'
      I18n.t('mother', scope: scope)
    else
      I18n.t('parent', scope: scope)
    end
  end

  def scope
    'relations'
  end
end
