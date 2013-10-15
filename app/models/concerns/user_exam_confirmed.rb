module Concerns
  module UserExamConfirmed
    extend ActiveSupport::Concern

    included do
      validate :exams_are_chosen

      private

      def exams_are_chosen
        unless language_paid_exams.blank?
          lgs = language_paid_exams.select(:exam_id, :language_id).includes(:language).select { |lg| lg.exam_id.nil? }
          unless lgs.empty?
            lgs.each do |language_grade|
              errors.add(:language_grades, "#{language_grade.language.try(:name)} has no exam time chosen.")
            end
          end
        end
      end
    end
  end
end