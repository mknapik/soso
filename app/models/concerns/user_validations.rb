module Concerns
  module UserValidations
    extend ActiveSupport::Concern

    included do
      validates :name,
                presence: true,
                length: {maximum: 50}

      validates :surname,
                presence: true,
                length: {maximum: 50}

      # Validates email format. Must have +@+ and domain.
      validates :email,
                presence: true,
                email: true,
                uniqueness: {case_sensitive: false, model: User},
                length: {maximum: 200}

      validates :password,
                presence: true,
                length: {minimum: 8, maximum: 100},
                if: :password

      # Study years from 1 to 5 + 2 years of PhD.
      #
      # Can be skipped by editors.
      validates :study_year,
                inclusion: {in: 1..7},
                allow_blank: true

      # Validates Zip postal format.
      # XX-XXX
      #
      # Examples:
      # * 65-123
      # * 32-054
      validates :zip,
                format: {with: /\A\d{2}-\d{3}\z|(^\z)/},
                allow_blank: true

      # Validates phone format.
      # DDD-DDD-DDD or DDD DDD DDD
      # with optional country code
      #
      # Examples:
      # * 654-234-123
      # * 654 234 123
      # * 48 123 546 678
      # * 048 123 654 234
      # * +48 987-654-432
      validates :phone,
                format: {with: /\A(?:(?:(?:(0\d{2,}|\+\d{2,})|\((0\d{2,}|\+\d{2,})\))\s*)?((\d{9})|((\d{3}-){2}\d{3})|((\d{3}\ ){2}\d{3}))|)\z/},
                allow_blank: true

      # +student_no+ number should be present unless entity is edited by editor.
      #
      # If it is not null then it has to be unique.
      validates :student_no,
                :uniqueness => {scope: :committee_id, case_sensitive: false, model: User},
                :allow_blank => true

      validates :role,
                :presence => true
    end
  end
end