# frozen_string_literal: true

module FamilyTextMethods
  extend ActiveSupport::Concern

  def idh
    ['#', id].join
    # designation
    # id
  end

  def full_family_text_description
    return nil unless id.present?

    result = {}
    full_family.each do |profile|
      result[profile.idh] = profile.text_description
    end
    result
  end

  def text_description
    result = []
    profile_data.each do |data|
      next unless data[:profiles].any?

      result.push(I18n.t('relation_of',
                         scope: scope,
                         relation: data[:description],
                         profiles: data[:profiles].map(&:idh).to_sentence))
    end
    result.push(I18n.t('relationship_with', scope: scope, couples: couples_idhs.to_sentence)) if couples.present?
    result
  end

  private

  def couples_idhs
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
      I18n.t('description.son', scope: scope)
    when 'female'
      I18n.t('description.daughter', scope: scope)
    else
      I18n.t('description.child', scope: scope)
    end
  end

  def sibling_description
    case gender
    when 'male'
      I18n.t('description.brother', scope: scope)
    when 'female'
      I18n.t('description.sister', scope: scope)
    else
      I18n.t('description.sibling', scope: scope)
    end
  end

  def parent_description
    case gender
    when 'male'
      I18n.t('description.father', scope: scope)
    when 'female'
      I18n.t('description.mother', scope: scope)
    else
      I18n.t('description.parent', scope: scope)
    end
  end

  def scope
    'relations'
  end
end
