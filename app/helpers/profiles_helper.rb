# frozen_string_literal: true

# top level description of ProfilesHelper
module ProfilesHelper
  def profile_privacies
    Profile::PRIVACIES.map { |option| [t(option, scope: :privacy), option] }
  end
end
