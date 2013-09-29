class PresentAssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.blank? or not value.size.in? options[:min]..options[:max]
      record.errors[attribute] << (options[:message] ||
          "number of elements is not between #{options[:min]} and #{options[:max]}"
      )
    end
  end
end

class UniqueAssociationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    key = "#{record.class.name.downcase}_id"
    foreign_key = options[:key]
    unless value.blank?
      size = value.map { |v| v.send(foreign_key) }.uniq.size
      unless size == value.size
        record.errors[attribute] << (options[:message] || "#{foreign_key} are not unique")
      end
    end
  end
end

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

module UserLanguageExamPaid
  extend ActiveSupport::Concern

  included do
    validate :language_exams_are_paid

    private

    def language_exams_are_paid
      if language_paid_exams.blank?
        language_enrolled_exams.includes(:language).map(&:language).each do |language|
          errors.add(:language_grades, "#{language.try(:name)} is not paid.")
        end
      end
    end
  end
end
