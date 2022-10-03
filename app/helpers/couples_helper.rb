# frozen_string_literal: true

# top level description of CouplesHelper
module CouplesHelper
  def partners_links(couple)
    content = couple.partners.map do |partner|
      next unless partner

      link_to(partner.designation, profile_path(partner.id, profile_id: nil))
    end.compact

    safe_join(content, raw('<div class="mx-1"> & </div>'))
  end
end
