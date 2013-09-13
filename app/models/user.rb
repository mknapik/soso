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

# == Schema Information
# Schema version: 20130819205637
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
  has_many :subjects, :through => :subject_grades

  #has_and_belongs_to_many :exam_appointments, :join_table => :users_exam_appointments

  validates_associated :language_grades
  has_many :language_grades

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

  include UserValidations
  include UserRegistered

  state_machine :initial => :registered do
    state all - [:registered] do
      include UserProfileFilled
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
    state :grades_filled do
    end
    state :language_exam_paid do
    end
    state :exam_chosen do
    end
    state :exam_confirmed do
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
      transition :grades_filled => :language_chosen
    end
    event :skip_exam do
      transition :grades_filled => :language_skipped, if: lambda { |user|
        not user.passed_language_exams.empty? and user.language_exam_enrollments.empty?
      }
    end
    # staff only
    event :confirm_grades do
      transition :language_chosen => :grades_confirmed
      transition :language_skipped => :exam_passed
    end
    # staff only
    event :pay_exam do
      transition :grades_confirmed => :language_exam_paid
    end
    event :choose_exam do
      transition :language_exam_paid => :exam_chosen
      #transition :exam_chosen => :exam_chosen # ?
    end
    event :change_exam do
      transition :exam_chosen => same
    end
    event :confirm_exam_attendance do
      transition :exam_chosen => :exam_confirmed
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

  #@params single role or iterable collection of roles
  #@@return true if user has role in specified range
  def role?(role_symbol)
    return role_symbol.nil? if self.role.nil?

    role_name = self.role.name
    return (not role_symbol.detect { |s| s.to_s == role_name }.nil?) if role_symbol.respond_to? :detect
    return self.role.name == role_symbol.to_s
  end

  private

  def confirmed?
    not confirmed_at.nil?
  end

  def clear_orphaned_priorities
    unless self.priority_orphans.nil?
      (self.priority_orphans - self.sector_priorities).each { |sp| sp.destroy }
      self.priority_orphans = nil
    end
  end

  public

  #@return sum of all ECTS for the user
  def sum_ects
    self.subject_grades.map(&:ects).sum
  end

  #@return average of user grades as string (3 decimal digits)
  def pretty_average
    '%.3f' % self.average
  end

  #@return average of user grades as string (3 decimal digits)
  def average
    return 0 if self.subject_grades.empty?
    tmp = self.subject_grades.map { |g| [g.grade*g.ects, g.ects] }.inject { |sum, g| [sum[0]+g[0], sum[1]+g[1]] }
    tmp[0]/tmp[1]
  end

  def sector_ids
    sector_priorities.select(:sector_id)
  end

  def sectors
    sector_priorities.includes(:sector).map(&:sector)
  end

  def sector_ids=(ids)
    ids.reject! { |id| id.blank? }
    self.set_priorities(ids.map { |id| Sector.find(id) }.map.with_index { |sector, index|
      SectorPriority.new(sector: sector, priority: index+1)
    })
  end

  def language_exam_enrollments(year=Setting.year(self.committee_id))
    self.language_grades.where(year: year, grade: nil)
  end

  def paid_language_exams(year=Setting.year(self.committee_id))
    self.language_grades.where(year: year, paid: true)
  end

  def passed_language_exams
    self.language_grades.where('grade IS NOT NULL')
  end

  def language_choices(languages, year=Setting.year(self.committee_id))
    old_languages = self.language_grades.where('year != ?', year)
    current_languages = self.language_grades.includes(:language).where(year: year)
    paid_languages = current_languages.where('paid = true AND grade IS NULL')
    unpaid_languages = current_languages.where(paid: nil, grade: nil)
    passed_languages = current_languages.where('grade IS NOT NULL')

    raise 'CannotSetExamWhichWasAlreadyPassed' if languages.detect do |language|
      passed_languages.map(&:language_id).include? language.id
    end

    new_language_grades = languages.map do |language|
      l = unpaid_languages.where(language_id: language.id).first_or_create
      puts l.inspect
      l
    end

    (unpaid_languages - new_language_grades).each { |e| e.destroy }
    self.language_grades = old_languages + paid_languages + new_language_grades
  end
end
