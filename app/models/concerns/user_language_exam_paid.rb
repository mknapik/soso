module Concerns
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
end