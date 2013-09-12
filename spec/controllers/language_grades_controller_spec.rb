require 'spec_helper'

describe LanguageGrades Controller do

    # This should return the minimal set of attributes required to create a valid
    # LanguageGrade. As you add validations to LanguageGrade, be sure to
    # update the return value of this method accordingly.
    def valid_attributes
      attributes_for :language_grade
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LanguageGrades Controller.Be sure to keep this updated too.
                                                                                                                   def valid_session
      {}
    end

    before do
      # TODO Set to :user and specify authorization rules in Ability.rb.
      # login_user build :admin
    end

      describe "#index" do
    it "assigns all language_grades
          as @language_grades" do
      language_grade = LanguageGrade.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:language_grades)).to eq([language_grade])
    end
  end

  describe "#show" do
    it "assigns the requested language_grade as @language_grade" do
      language_grade = LanguageGrade.create! valid_attributes
      get :show, { :id => language_grade.to_param }, valid_session
      expect(assigns(:language_grade)).to eq(language_grade)
    end
  end

  describe "#new" do
    it "assigns a new language_grade as @language_grade" do
      get :new, {}, valid_session
      expect(assigns(:language_grade)).to be_a_new(LanguageGrade)
    end
  end

  describe "#edit" do
    it "assigns the requested language_grade as @language_grade" do
      language_grade = LanguageGrade.create! valid_attributes
      get :edit, { :id => language_grade.to_param }, valid_session
      expect(assigns(:language_grade)).to eq(language_grade)
    end
  end

  describe "#create" do
    describe "with valid params" do
      it "creates a new LanguageGrade" do
        expect {
          post :create, { :language_grade => valid_attributes }, valid_session
        }.to change(LanguageGrade, :count).by(1)
      end

      it " assigns a newly created language_grade as @language_grade" do
        post :create, {:language_grade => valid_attributes }, valid_session
        expect(assigns(:language_grade)).to be_a(LanguageGrade)
        expect(assigns(:language_grade)).to be_persisted
      end

      it " redirects to the created language_grade" do
        post :create, { :language_grade => valid_attributes}, valid_session
          expect(response).to redirect_to(LanguageGrade.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved language_grade as @language_grade" do
        # Trigger the behavior that occurs when invalid params are submitted
        LanguageGrade.any_instance.stub(:save).and_return(false)
          post :create, {:language_grade => { "user" => "invalid value" } }, valid_session
        expect(assigns(:language_grade)).to be_a_new(LanguageGrade)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        LanguageGrade.any_instance.stub(:save).and_return(false)
          post :create, {:language_grade => { "user" => "invalid value" } }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    describe "with valid params" do
      it "updates the requested language_grade" do
        language_grade = LanguageGrade.create! valid_attributes
        # Assuming there are no other language_grades in the database, this
        # specifies that the LanguageGrade created on the previous line
        # receives the :update message with whatever params are submitted in
        # the request.
        LanguageGrade.any_instance.should_receive(:update).with({ "user" => "" })
        put :update, { :id => language_grade.to_param, :language_grade => { "user" => "" } }, valid_session
      end

      it " assigns the requested language_grade as @language_grade" do
        language_grade = LanguageGrade.create! valid_attributes
        put :update, { :id => language_grade.to_param, :language_grade => valid_attributes }, valid_session
        expect(assigns(:language_grade)).to eq(language_grade)
      end

      it " redirects to the language_grade" do
        language_grade = LanguageGrade.create! valid_attributes
        put :update, { :id => language_grade.to_param, :language_grade => valid_attributes}, valid_session
          expect(response).to redirect_to(language_grade)
      end
    end

    describe "with invalid params" do
      it "assigns the language_grade as @language_grade" do
        language_grade = LanguageGrade.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LanguageGrade.any_instance.stub(:save).and_return(false)
          put :update, {:id => language_grade.to_param, :language_grade => { "user" => "invalid value" } }, valid_session
        expect(assigns(:language_grade)).to eq(language_grade)
      end

      it "re-renders the 'edit' template" do
        language_grade = LanguageGrade.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        LanguageGrade.any_instance.stub(:save).and_return(false)
          put :update, {:id => language_grade.to_param, :language_grade => { "user" => "invalid value" } }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested language_grade" do
      language_grade = LanguageGrade.create! valid_attributes
      expect {
        delete :destroy, { :id => language_grade.to_param }, valid_session
      }.to change(LanguageGrade, :count).by(-1)
    end

    it " redirects to the language_grades list" do
      language_grade = LanguageGrade.create! valid_attributes
      delete :destroy, { :id => language_grade.to_param }, valid_session
      expect(response).to redirect_to(language_grades_url)
        end
  end

end
