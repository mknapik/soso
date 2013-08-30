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
  has_many :sector_priorities
  validates_associated :sector_priorities
  after_save :clear_orphaned_priorities

  def set_priorities(priorities, validate=true)
    sps = self.sector_priorities
    self.priority_orphans = [] if self.priority_orphans.nil?
    self.priority_orphans = (priority_orphans + sps - priorities).to_a
    self.sector_priorities = priorities
  end

  #has_many :subject_grades
  #has_many :subjects, :through => :subject_grades

  #has_and_belongs_to_many :exam_appointments, :join_table => :users_exam_appointments

  #has_many :language_grades
  #has_many :languages, through: :language_grades

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
    event :edit_data do
      transition :registered => :profile_filled

      transition :profile_filled => same
      transition :cv_uploaded => same
      transition :grades_filled => same
    end
    event :upload_cv do
      transition :profile_filled => :cv_uploaded
    end
    #event :fill_grades do
    #  transition :profile_filled => :grades_filled
    #  transition :cv_uploaded => :grades_filled
    #  # transition :grades_filled => :grades_filled # ?
    #end
    event :edit_grades do
      transition :profile_filled => :grades_filled
      transition :cv_uploaded => :grades_filled

      transition :grades_filled => same
    end
    event :choose_language do
      transition :grades_filled => :language_chosen
    end
    event :choose_grades_from_previous_years do
      transition :grades_filled => :language_skipped
    end
    event :confirm_grades do
      transition :language_chosen => :grades_confirmed
      transition :language_skipped => :exam_passed
    end
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
    event :upload_positive_language_grade do
      transition :exam_confirmed => :exam_passed
    end
    event :upload_negative_language_grade do
      transition :exam_confirmed => :suspended
    end
    event :publish_preliminary_ranking do
      transition :exam_passed => :preliminary_ranking
    end
    event :complain_about_ranking do
      transition :preliminary_ranking => same
    end
    event :preview_ranking do
      transition :preliminary_ranking => same
    end
    event :publish_ranking do
      transition :preliminary_ranking => :ranking
    end
    event :view_ranking do
      transition :ranking => :ranking
    end
    event :publish_offers do
      transition :ranking => :offers_published
    end
    event :edit_priority do
      transition :offers_published => same
    end
    event :assign_offers do
      transition :offers_published => :offer_assigned
    end
    event :give_up do
      transition :offer_assigned => :suspended
    end
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
    event :send_for_fixes do # TODO: change name
      transition :documents_published => :application
    end
    event :comment_document do # TODO: change name
      transition :documents_published => same
    end
    event :accept_document do
      transition :documents_published => same
    end
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
  def sector_ids
    sector_priorities.map { |sp| sp.sector_id }
  end

  def sectors
    sector_priorities.map { |sp| sp.sector }
  end

  def sector_ids= ids
    ids.reject! { |id| id.blank? }
    self.set_priorities(ids.map { |id| Sector.find(id) }.map.with_index { |sector, index|
      SectorPriority.new(sector: sector, priority: index+1)
    })
  end
end
