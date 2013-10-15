module Concerns
  module UserExam
    extend ActiveSupport::Concern

    included do
      def exam_sign_up(exam)
        lgs = self.language_paid_exams.where(language_id: exam.language_id)
        return false if lgs.empty?
        raise ValueError, 'More than two payments for same language!' if lgs.size > 1
        lg = lgs.first
        if lg.exam.nil?
          lg.exam = exam
          lg.save
        else
          false
        end
      end

      def exam_release(exam)
        lgs = self.language_paid_exams.includes(:exam)
        if exam.in? lgs.map(&:exam)
          lg = lgs.where(language_id: exam.language_id).first
          lg.exam = nil
          lg.save
        else
          false
        end
      end
    end
  end

end