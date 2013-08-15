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

  belongs_to :role

  ## Setup accessible (or protected) attributes for your model
  #attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :role_id

  validates :name,
            presence: true,
            length: {maximum: 50}
  validates :surname,
            presence: true,
            length: {maximum: 50}
  validates :email,
            presence: true,
            email: true,
            uniqueness: true,
            length: {maximum: 200}
  validates :password,
            presence: true,
            length: {minimum: 8, maximum: 100},
            if: :password

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

  def role? i
    return i == role
    raise NotImplementedError
  end

end
