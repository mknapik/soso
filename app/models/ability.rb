class Ability
  include CanCan::Ability

  def initialize(user)
    def owner_or_staff?(user, current_user)
      user.id == current_user.id ||
          current_user.role_id == 1 ||
          (current_user.committee_id == user.committee_id && current_user.staff?)
    end

    def staff?(user, current_user)
      user.id != current_user.id &&
          (
          current_user.role_id == 1 ||
              (current_user.committee_id == user.committee_id && current_user.staff?)
          )
    end

    user ||= ::User.new # guest user (not logged in)
    user_id = user.id

    if user.role_id.in? [1, 2]
      can :access, :rails_admin # grant access to rails_admin
      can :dashboard # grant access to the dashboard

      if user.role? :superadmin
        can :read, User

        can [:read, :update], User

        can :manage, Faculty
        can :manage, FieldOfStudy
        can :manage, Specialization
        can :manage, Subject
        can :manage, Faq

        can [:create, :destroy], SubjectGrade
        can [:read, :update], LanguageGrade

        can :manage, [Country, City, Committee]
      else
        can [:read, :update], User, committee_id: user.committee_id

        can :manage, Faculty, committee_id: user.committee_id
        can :manage, FieldOfStudy, faculty: {committee_id: user.committee_id}
        can :manage, Specialization, field_of_study: {faculty: {committee_id: user.committee_id}}
        can :manage, Subject, committee_id: user.committee_id
        can :manage, Faq, committee_id: user.committee_id

        can :read, [Country, City, Committee]
        can :manage, Committee, id: user.committee_id
        can [:update, :destroy], Faq # delete me!
      end
    else
      can [:read, :update], User, id: user_id
    end

    # No one can destroy themselves.
    cannot :destroy, User, id: user_id

    can :read, Page, ['? IS NOT NULL OR public', user_id] do |page|
      !user_id.nil? || page.public
    end

    # TODO
    can :read, user
    can :read, :faq
    can :read, :news
    can :read, :ranking
    can :read, :offers

    # staff
    if user.staff?
      can :read, User
      can :confirm_grades, User do |u|
        staff?(u, user) && u.can_confirm_grades?
      end
      if user.role_id.in? 1..3
        can :disapprove_grades, User do |u|
          staff?(u, user) && u.can_disapprove_grades?
        end
      end
      can :pay_exam_fee, User do |u|
        staff?(u, user) && u.can_pay_exam_fee?
      end

      can [:create, :destroy], SubjectGrade, user: {committee_id: user.committee_id}
      can [:read, :update], LanguageGrade, user: {committee_id: user.committee_id}
    end

    # events in chronogical order
    if user.role_id.in? [1, 2]
      can :upload_positive_language_grade, User do |u|
        u.id != user_id
      end
      can :upload_negative_language_grade, User do |u|
        u.id != user_id
      end

      can :publish_preliminary_ranking, User
      can :publish_ranking, User
      can :publish_offers, User
      can :assign_offers, User

      can :pay_deposit, User do |u|
        u.id != user_id
      end
      can :send_for_fixes, User do |u|
        u.id != user_id
      end
      can :comment_document, User do |u|
        u.id != user_id
      end
      can :comment_application, User do |u|
        u.id != user_id
      end
      can :accept_document, User do |u|
        u.id != user_id
      end
      cannot :accept_application, User, id: user_id
      can :accept_application, User

      can :download_documents, User
    end

    can :view_profile, User do |u|
      owner_or_staff?(u, user)
    end
    can :edit_profile, User do |u|
      owner_or_staff?(u, user) && u.can_edit_profile?
    end
    can :edit_grades, User do |u|
      owner_or_staff?(u, user) && u.can_edit_grades?
    end
    can :view_grades, User do |u|
      owner_or_staff?(u, user) && u.can_view_grades?
    end
    can :lock_profile, User do |u|
      owner_or_staff?(u, user) && u.can_lock_profile?
    end
    can :unlock_profile, User do |u|
      owner_or_staff?(u, user) && u.can_unlock_profile?
    end
    can :upload_cv, User do |u|
      owner_or_staff?(u, user) && u.can_upload_cv?
    end
    can :choose_language, User do |u|
      owner_or_staff?(u, user) && u.can_choose_language?
    end
    can :lock_language, User do |u|
      owner_or_staff?(u, user) && u.can_lock_language?
    end
    can :choose_exam, User do |u|
      owner_or_staff?(u, user) && u.can_choose_exam?
    end
    can :choose, Language do |language|
      user.committee.languages.include? language
    end
    can :skip_exam, User do |u|
      owner_or_staff?(u, user) && u.can_skip_exam?
    end
    can :lock_exam, User do |u|
      owner_or_staff?(u, user) && u.can_lock_exam?
    end
    can :read, Faculty, committee_id: user.committee_id
    can :read, FieldOfStudy, faculty: {committee_id: user.committee_id}
    can :read, Specialization, field_of_study: {faculty: {committee_id: user.committee_id}}
    can :read, Subject, committee_id: user.committee_id
    can :read, Faq, published: true, committee_id: user.committee_id
    can :read, Faq, published: true, public: true
    can [:create, :destroy], SubjectGrade, user_id: user.id
    can [:read, :update], LanguageGrade, user_id: user.id
    can [:update, :destroy], Faq # delete me!

    # No one can destroy themselves.
    cannot :destroy, User, id: user.id

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving
    # the user permission to, User { |u| u.id == user_id }.
    # If you pass :manage it will apply to every action.
    # Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform
    # the action on. If you pass :all it will apply to every resource.
    # Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further
    # filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    #   https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
