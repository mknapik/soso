# == Schema Information
# Schema version: 20130830004029
#
# Table name: users
#
# *id*::                     <tt>integer, not null, primary key</tt>
# *name*::                   <tt>string(50), not null</tt>
# *surname*::                <tt>string(50), not null</tt>
# *email*::                  <tt>string(200), not null, indexed</tt>
# *encrypted_password*::     <tt>string(255), default(""), not null</tt>
# *reset_password_token*::   <tt>string(255), indexed</tt>
# *reset_password_sent_at*:: <tt>datetime</tt>
# *remember_created_at*::    <tt>datetime</tt>
# *sign_in_count*::          <tt>integer, default(0)</tt>
# *current_sign_in_at*::     <tt>datetime</tt>
# *last_sign_in_at*::        <tt>datetime</tt>
# *current_sign_in_ip*::     <tt>string(255)</tt>
# *last_sign_in_ip*::        <tt>string(255)</tt>
# *confirmation_token*::     <tt>string(255), indexed</tt>
# *confirmed_at*::           <tt>datetime</tt>
# *confirmation_sent_at*::   <tt>datetime</tt>
# *unconfirmed_email*::      <tt>string(255)</tt>
# *failed_attempts*::        <tt>integer, default(0)</tt>
# *unlock_token*::           <tt>string(255), indexed</tt>
# *locked_at*::              <tt>datetime</tt>
# *created_at*::             <tt>datetime</tt>
# *updated_at*::             <tt>datetime</tt>
# *role_id*::                <tt>integer, indexed</tt>
# *study_year*::             <tt>integer</tt>
# *birth_date*::             <tt>date</tt>
# *student_no*::             <tt>string(255), indexed => [committee_id]</tt>
# *street*::                 <tt>string(255)</tt>
# *house*::                  <tt>string(255)</tt>
# *city*::                   <tt>string(255)</tt>
# *zip*::                    <tt>string(255)</tt>
# *phone*::                  <tt>string(255)</tt>
# *committee_id*::           <tt>integer, indexed, indexed => [student_no]</tt>
# *field_of_study_id*::      <tt>integer, indexed</tt>
# *specialization_id*::      <tt>integer, indexed</tt>
# *faculty_id*::             <tt>integer, indexed</tt>
# *state*::                  <tt>string(255), default("registered"), not null</tt>
#
# Indexes
#
#  index_users_on_committee_id                 (committee_id)
#  index_users_on_committee_id_and_student_no  (committee_id,student_no) UNIQUE
#  index_users_on_confirmation_token           (confirmation_token) UNIQUE
#  index_users_on_email                        (email) UNIQUE
#  index_users_on_faculty_id                   (faculty_id)
#  index_users_on_field_of_study_id            (field_of_study_id)
#  index_users_on_reset_password_token         (reset_password_token) UNIQUE
#  index_users_on_role_id                      (role_id)
#  index_users_on_specialization_id            (specialization_id)
#  index_users_on_unlock_token                 (unlock_token) UNIQUE
#--
# == Schema Information End
#++

class User < ActiveRecord::Base
  attr_accessor :priority_orphans
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  belongs_to :committee
  belongs_to :role

  belongs_to :faculty
  belongs_to :field_of_study
  belongs_to :specialization
  has_many :sector_priorities, autosave: true
  validates_associated :sector_priorities
  after_save :clear_orphaned_priorities

  def set_priorities(priorities, validate=true)
    sps = self.sector_priorities
    self.priority_orphans = [] if self.priority_orphans.nil?
    self.priority_orphans = (priority_orphans + sps - priorities).to_a
    self.sector_priorities = priorities
  end

  has_many :subject_grades
  has_many :subjects, through: :subject_grades

  #has_and_belongs_to_many :exam_appointments, join_table: :users_exam_appointments

  validates_associated :language_grades
  has_many :language_grades, autosave: true
  has_many :exams, through: :language_grades

  def bypass=(bypass)
    @bypass = bypass
  end

  def bypass?
    @bypass
  end

  before_validation :default_role

  def default_role
    self.role ||= Role.user
  end

  def full_name
    "#{name} #{surname}"
  end

  include Concerns::UserValidations
  include Concerns::UserRegistered

  def can_view_grades?
    false
  end

  def staff?
    role_id.in?(1..4)
  end

  state_machine :initial => :registered do
    state all - [:registered] do
      include Concerns::UserProfileFilled
    end
    state :grades_filled, :language_chosen, :language_skipped, :grades_confirmed do
      def can_view_grades?
        true
      end
    end
    state all - [:language_exam_paid] do
      def exam_sign_up(exam)
        false
      end

      def exam_release(exam)
        false
      end
    end
    state :language_exam_paid do
    end

    state :unregistered do
    end
    state :registered do
    end
    state :profile_filled do
    end
    state :cv_uploaded do
    end
    state :grades_filled do
    end
    state :language_chosen do
    end
    state :language_skipped do
    end
    state :grades_confirmed do
    end
    state :language_exam_paid do
      include Concerns::UserLanguageExamPaid
      include Concerns::UserExam
    end
    state :exam_confirmed do
      include Concerns::UserLanguageExamPaid
      include Concerns::UserExamConfirmed
    end
    state :exam_passed do
    end
    state :preliminary_ranking do
    end
    state :ranking do
    end
    state :offers_published do
    end
    state :offer_assigned do
    end
    state :application do
    end
    state :documents_published do
    end
    state :documents_accepted do
    end
    state :suspended do
    end

    # rubocop:disable HashSyntax
    event :sign_up do
      transition :unregistered => :registered
    end
    event :sign_in do
      transition :unregistered => :registered
    end
    event :edit_profile do
      transition :registered => :profile_filled

      transition :profile_filled => same
      transition :cv_uploaded => same
    end
    event :upload_cv do
      transition :profile_filled => :cv_uploaded
    end
    event :edit_grades do
      transition :profile_filled => same
      transition :cv_uploaded => same
    end
    event :lock_profile do
      transition [:cv_uploaded, :profile_filled] => :grades_filled, :if => lambda { |user|
        user.subject_grades.count > 0
      }
    end
    event :unlock_profile do
      transition :grades_filled => :profile_filled
    end
    event :choose_language do
      transition :grades_filled => :grades_filled
    end
    event :lock_language do
      transition :grades_filled => :language_chosen
    end
    event :skip_exam do
      transition :grades_filled => :language_skipped, if: lambda { |user|
        !user.language_passed_exams.empty? and user.language_enrolled_exams.empty?
      }
    end
    # staff only
    event :confirm_grades do
      transition :language_chosen => :grades_confirmed
      transition :language_skipped => :exam_passed
    end
    # manager only
    event :disapprove_grades do
      transition :grades_confirmed => :language_chosen
      transition :exam_passed => :language_skipped
    end
    # staff only
    event :pay_exam_fee do
      transition :grades_confirmed => :language_exam_paid
    end
    event :choose_exam do
      transition :language_exam_paid => same
    end
    event :lock_exam do
      transition :language_exam_paid => :exam_confirmed, :if => lambda { |user|
        !user.language_paid_exams.select(:exam_id).any? { |lg| lg.exam_id.nil? }
      }
    end
    # staff only
    event :upload_positive_language_grade do
      transition :exam_confirmed => :exam_passed
    end
    # staff only
    event :upload_negative_language_grade do
      transition :exam_confirmed => :suspended
    end
    # manager only
    event :publish_preliminary_ranking do
      transition :exam_passed => :preliminary_ranking
    end
    event :complain_about_ranking do
      transition :preliminary_ranking => same
    end
    event :preview_ranking do
      transition :preliminary_ranking => same
    end
    # manager only
    event :publish_ranking do
      transition :preliminary_ranking => :ranking
    end
    event :view_ranking do
      transition :ranking => :ranking
    end
    # manager only
    event :publish_offers do
      transition :ranking => :offers_published
    end
    event :edit_priority do
      transition :offers_published => same
    end
    # manager only
    event :assign_offers do
      transition :offers_published => :offer_assigned
    end
    event :give_up do
      transition :offer_assigned => :suspended
    end
    # staff only
    event :pay_deposit do
      transition :offer_assigned => :application
    end
    event :upload_documents do
      transition :application => same
    end
    event :edit_documents do
      transition :application => same
    end
    event :publish_documents do
      transition :application => :documents_published
    end
    # staff only
    event :send_for_fixes do # TODO: change name
      transition :documents_published => :application
    end
    # staff only
    event :comment_document do # TODO: change name
      transition :documents_published => same
    end
    # staff only
    event :accept_document do
      transition :documents_published => same
    end
    # staff only
    event :accept_application do
      transition :documents_published => :documents_accepted
    end
    event :download_documents do
      transition :documents_accepted => same
    end
  end
  # rubocop:enable HashSyntax

  #@params single role or iterable collection of roles
  #@@return true if user has role in specified range
  def role?(role_symbol)
    return role_symbol.nil? if self.role.nil?

    if role_symbol.respond_to? :detect
      (!role_symbol.detect { |s| s.to_s == self.role.name }.nil?)
    else
      self.role.name == role_symbol.to_s
    end
  end

  private

  def confirmed?
    !confirmed_at.nil?
  end

  def clear_orphaned_priorities
    unless self.priority_orphans.nil?
      (self.priority_orphans - self.sector_priorities).each { |sp| sp.destroy }
      self.priority_orphans = nil
    end
  end

  public

  # @return sum of all ECTS for the user
  def sum_ects
    self.subject_grades.map(&:ects).sum
  end

  # @return average of user grades as string (3 decimal digits)
  def pretty_average
    '%.3f' % self.average
  end

  # @return average of user grades as string (3 decimal digits)
  def average
    return 0 if self.subject_grades.empty?
    tmp = self.subject_grades.map { |g| [g.grade * g.ects, g.ects] }.inject { |sum, g| [sum[0] + g[0], sum[1] + g[1]] }
    tmp[0] / tmp[1]
  end

  def sector_ids
    sector_priorities.pluck(:sector_id)
  end

  def sectors
    sector_priorities.includes(:sector).map(&:sector)
  end

  def sector_ids=(ids)
    ids.reject! { |id| id.blank? }
    self.set_priorities(ids.map { |id| Sector.find(id) }.map.with_index do |sector, index|
      SectorPriority.new(sector: sector, priority: index + 1)
    end)
  end

  # @return LanguageGrades which are enrolled for current year
  def language_enrolled_exams(year = Setting.year(self.committee_id))
    self.language_grades.where(year: year, grade: nil)
  end

  # @return LanguageGrades which are enrolled and paid for current year
  def language_paid_exams(year = Setting.year(self.committee_id))
    self.language_grades.where(year: year, paid: true)
  end

  # @return LanguageGrades which were passed (any year)
  def language_passed_exams
    self.language_grades.where('grade IS NOT NULL')
  end

  # @return LanguageGrades which are enrolled and the time is chosen for current year
  def language_signed_up_exams(year = Setting.year(self.committee_id))
    self.language_paid_exams.includes(:exam).map(&:exam).compact
  end

  # sets LanguageGrades according to current choices (usually for current year)
  def language_choices(languages, year = Setting.year(self.committee_id))
    old_languages = self.language_grades.where('year != ?', year)
    current_languages = self.language_grades.includes(:language).where(year: year)
    paid_languages = current_languages.where('paid = true AND grade IS NULL')
    unpaid_languages = current_languages.where(paid: nil, grade: nil)
    passed_languages = current_languages.where('grade IS NOT NULL')

    raise 'CannotSetExamWhichWasAlreadyPassed' if languages.detect do |language|
      passed_languages.pluck(:language_id).include? language.id
    end

    new_language_grades = languages.map do |language|
      unpaid_languages.where(language_id: language.id).first_or_create
    end

    (unpaid_languages - new_language_grades).each { |e| e.destroy }
    self.language_grades = old_languages + paid_languages + new_language_grades
  end

  def language_exam_calendar_data
    {
        languages: Hash[*self.language_paid_exams.map { |lg| [lg.language_id, lg.exam_id] }.flatten],
        user_id: self.id
    }
  end
end
