module Concerns
  module UserProfileFilled
    extend ActiveSupport::Concern

    included do
      # Fields required while editing profile. Not required on registration.
      #
      # Can be skipped by editors.
      validates :zip, :city, :house, :birth_date, :faculty_id, :field_of_study_id, :study_year, :phone,
                presence: true,
                unless: :bypass?

      # Presence of priorities is required.
      #
      # Not required on registration.
      # Can be skipped by editors.
      validates :sector_priorities,
                present_association: {min: 1, max: 3},
                unique_association: {key: :sector_id},
                unless: :bypass?

      ## Priorities must be different.
      ##
      ## Not required on registration.
      validates :sector_priorities,
                unique_association: {key: :priority}
    end
  end
end