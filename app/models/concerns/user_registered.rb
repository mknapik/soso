module Concerns
  module UserRegistered
    extend ActiveSupport::Concern

    included do
      # Fields required on registration.
      #
      # Validation is needed for simple_form.
      # Can be skipped by editors.
      validates :student_no, :committee_id,
                presence: true,
                unless: :bypass?
    end
  end
end