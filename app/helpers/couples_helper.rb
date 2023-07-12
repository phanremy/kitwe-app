# frozen_string_literal: true

# top level description of CouplesHelper
module CouplesHelper
  def child_of(parents)
    content_tag(:div, class: 'flex') do
      partners_links(parents)
    end
  end

  def partners_links(couple)
    content = couple.partners.map do |partner|
      next unless partner

      link_to(partner.designation, profile_path(partner.id, profile_id: nil))
    end.compact

    safe_join(content, raw('<div class="mx-1"> & </div>'))
  end

  def other_partner_link(couple, profile)
    other_partner = couple.other_partner(profile)

    if other_partner.blank?
      'Single'
    else
      link_to(other_partner.designation, profile_path(other_partner.id, profile_id: nil))
    end
  end
end
