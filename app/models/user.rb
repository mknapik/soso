# == Schema Information
# Schema version: 20130331212354
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
# *role_id*::                <tt>integer, default(3), not null</tt>
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#--
# == Schema Information End
#++

class User < ActiveRecord::Base
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

  #has_many :subject_grades
  #has_many :subjects, :through => :subject_grades

  #has_and_belongs_to_many :exam_appointments, :join_table => :users_exam_appointments
  #has_many :sector_priorities
  #has_many :sectors, :through => :sector_priorities, :order => :priority

  #has_many :language_grades
  #has_many :languages, through: :language_grades

  def bypass=(bypass)
    @bypass = bypass
  end

  def bypass?
    @bypass
  end

  # Fields required on registration.
  #
  # Validation is needed for simple_form.
  # Can be skipped by editors.
  validates :index, :name, :surname, :committee_id,
            :presence => true,
            :unless => :bypass?

  # Fields required while editing profile. Not required on registration.
  #
  # Can be skipped by editors.
  validates :zip, :city, :house, :birth_date, :faculty_id, :course_id,
            presence: true,
            #if: :confirmed?,
            unless: :bypass?

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
            uniqueness: true,
            length: {maximum: 200}

  validates :password,
            presence: true,
            length: {minimum: 8, maximum: 100},
            if: :password

  # Study years from 1 to 5 + 2 years of PhD.
  #
  # Can be skipped by editors.
  validates :year,
            inclusion: [in: 1..7],
            allow_blank: true

  # Validates Zip postal format.
  # XX-XXX
  #
  # Examples:
  # * 65-123
  # * 32-054
  validates :zip,
            format: {with: /^\d{2}-\d{3}$|(^$)/},
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
  validates :tel,
            format: {with: /^(?:(?:(?:(0\d{2,}|\+\d{2,})|\((0\d{2,}|\+\d{2,})\))\s*)?((\d{9})|((\d{3}-){2}\d{3})|((\d{3}\ ){2}\d{3}))|)$/},
            allow_blank: true

  validates :role_id,
            :presence => true

  # +index+ number should be present unless entity is edited by editor.
  #
  # If it is not null then it has to be unique.
  validates :index,
            :uniqueness => true,
            :allow_blank => true

  # Presence of priorities is required.
  #
  # Not required on registration.
  # Can be skipped by editors.
  validate :presence_of_sector_priorities,
           #if: :confirmed?,
           unless: :bypass?

  # Priorities must be different.
  #
  # Not required on registration.
  validate :uniqueness_of_sector_priorities,
           :if => :confirmed?

  # TODO: is needed?
  ## Always provide reason for blocking user.
  #validates :why_blocked,
  #          :presence => true,
  #          :if => :blocked

  def full_name
    "#{name} #{surname}"
  end

  state_machine :initial => :registered do
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
    event :fill_data do
      transition :registered => :profile_filled
    end
    event :edit_data do
      transition :profile_filled => :profile_filled
      transition :cv_uploaded => :cv_uploaded
      transition :grades_filled => same
    end
    event :upload_cv do
      transition :profile_filled => :cv_uploaded
    end
    event :fill_grades do
      transition :profile_filled => :grades_filled
      transition :cv_uploaded => :grades_filled
      # transition :grades_filled => :grades_filled # ?
    end
    event :edit_grade do
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

  ## Presence of sector priorities is required.
  #def presence_of_sector_priorities
  #  number_of_preferred_sectors = 3
  #  if self.sector_priorities.reject { |sp| sp.sector_id.nil? }.count < number_of_preferred_sectors
  #    errors.add(:sector_priorities, :should_be_present)
  #  end
  #end

  ## Sector priorities must be different.
  #def uniqueness_of_sector_priorities
  #  sector_ids = []
  #  self.sector_priorities.each do |sp|
  #    if sector_ids.include?(sp.sector_id)
  #      errors.add(:sector_priorities, :should_be_different)
  #      return
  #    end
  #    sector_ids.push(sp.sector_id) unless sp.sector_id.nil?
  #  end
  #end

end
