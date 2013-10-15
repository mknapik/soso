class Ability
  include CanCan::Ability

  def initialize(user)
    def owner_or_staff?(user, current_user)
      user.id == current_user.id or
          current_user.role_id == 1 or
          (current_user.committee_id == user.committee_id and current_user.role_id.in? 1..4)
    end

    def staff?(user, current_user)
      user.id != current_user.id and
          (
          current_user.role_id == 1 or
              (current_user.committee_id == user.committee_id and current_user.role_id.in? 1..4)
          )
    end

    user ||= ::User.new # guest user (not logged in)
    user_id = user.id

    if user.role_id.in? [1, 2]
      can :access, :rails_admin # grant access to rails_admin
      can :dashboard # grant access to the dashboard

      if user.role? :superadmin
        can :view, User

        can [:read, :update], User

        can :manage, Faculty
        can :manage, FieldOfStudy
        can :manage, Specialization
        can :manage, Subject
        can :manage, Faq

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

        can [:create, :delete], SubjectGrade do |subject_grade|
          user.id == subject_grade.user_id
        end
        can [:view, :edit], LanguageGrade do |language_grade|
          user.id == language_grade.user_id
        end
        can [:edit, :delete], Faq # delete me!

        # No one can destroy themselves.
        cannot :destroy, User, id: user.id

      end
    else
      can [:read, :update], User, id: user.id
    end

    if user.role_id.in? [:manager, :admin]

    end

    can :view, Page do |page|
      not user_id.nil? or page.public
    end

    # TODO
    can :view, user
    can :view, :faq
    can :view, :news
    can :view, :ranking
    can :view, :offers

    # staff
    if user.role_id.in? 1..4
      can :view, User
      can :confirm_grades, User do |u|
        staff?(u, user) and u.can_confirm_grades?
      end
      if user.role_id.in? 1..3
        can :disapprove_grades, User do |u|
          staff?(u, user) and u.can_disapprove_grades?
        end
      end
      can :pay_exam_fee, User do |u|
        staff?(u, user) and u.can_pay_exam_fee?
      end

      can [:create, :delete], SubjectGrade do |subject_grade|
        staff?(subject_grade.user, user)
      end
      can [:view, :edit], LanguageGrade do |language_grade|
        staff?(language_grade.user, user)
      end
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
      owner_or_staff?(u, user) and u.can_edit_profile?
    end
    can :edit_grades, User do |u|
      owner_or_staff?(u, user) and u.can_edit_grades?
    end
    can :view_grades, User do |u|
      owner_or_staff?(u, user) and u.can_view_grades?
    end
    can :lock_profile, User do |u|
      owner_or_staff?(u, user) and u.can_lock_profile?
    end
    can :unlock_profile, User do |u|
      owner_or_staff?(u, user) and u.can_unlock_profile?
    end
    can :upload_cv, User do |u|
      owner_or_staff?(u, user) and u.can_upload_cv?
    end
    can :choose_language, User do |u|
      owner_or_staff?(u, user) and u.can_choose_language?
    end
    can :lock_language, User do |u|
      owner_or_staff?(u, user) and u.can_lock_language?
    end
    can :choose_exam, User do |u|
      owner_or_staff?(u, user) and u.can_choose_exam?
    end
    can :choose, Language do |language|
      user.committee.languages.include? language
    end
    can :skip_exam, User do |u|
      owner_or_staff?(u, user) and u.can_skip_exam?
    end
    can :lock_exam, User do |u|
      owner_or_staff?(u, user) and u.can_lock_exam?
    end
    can :view, Faculty do |faculty|
      user.committee_id == faculty.committee_id
    end
    can :view, FieldOfStudy do |field_of_study|
      can? :view, field_of_study.faculty
    end
    can :view, Specialization do |specialization|
      can? :view, specialization.field_of_study
    end
    can :view, Subject do |subject|
      user.committee_id == subject.committee_id
    end
    can :view, Faq do |faq|
      faq.published and (faq.public or user.committee_id == faq.committee_id)
    end
    can [:create, :delete], SubjectGrade do |subject_grade|
      user.id == subject_grade.user_id
    end
    can [:view, :edit], LanguageGrade do |language_grade|
      user.id == language_grade.user_id
    end
    can [:edit, :delete], Faq # delete me!

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
    # the user permission to, User {|u| u.id == user_id}.
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    #   https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
