class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= ::User.new # guest user (not logged in)
    user_id = user.id

    if user.role_id.in? [1, 2]
      can :manage, :all
    else
      can [:read, :update], User, id: user.id
    end

    if user.role_id.in? [:manager, :admin]

    end

                        # events in chronogical order
    if user.role_id.in? [3]
      can :sign_up, User, id: user_id
      can :sign_in, User, id: user_id
      can :edit_profile, User, id: user_id
      can :upload_cv, User, id: user_id
      can :fill_grades, User, id: user_id
      can :edit_grade, User, id: user_id
      can :choose_language, User, id: user_id
      can :choose_grades_from_previous_years, User, id: user_id

      can :choose_exam, User, id: user_id
      can :change_exam, User, id: user_id
      can :confirm_exam_attendance, User, id: user_id
      can :complain_about_ranking, User, id: user_id
      can :preview_ranking, User, id: user_id
      can :view_ranking, User, id: user_id
      can :edit_priority, User, id: user_id
      can :give_up, User, id: user_id
      can :upload_documents, User, id: user_id
      can :edit_documents, User, id: user_id
      can :publish_documents, User, id: user_id
      can :download_documents, User, id: user_id
    end

    # events in chronogical order
    if user.role_id.in? [1, 2]
      can :confirm_grades, User do |u|
        u.id != user_id
      end
      can :pay_exam, User do |u|
        u.id != user_id
      end
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
      u.id == user_id
    end
    can :edit_profile, User do |u|
      u.id == user_id and u.can_edit_profile?
    end
    can :edit_grades, User do |u|
      u.id == user_id and u.can_edit_grades?
    end
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
