require 'spec_helper'

describe ExamsController do

  # This should return the minimal set of attributes required to create a valid
  # Exam. As you add validations to Exam, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes_for :exam
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # Exams Controller.Be sure to keep this updated too.
  def valid_session
    {}
  end

  before do
    # TODO Set to :user and specify authorization rules in Ability.rb.
    # login_user build :admin
  end

  describe '#index' do
    it 'assigns all exams
          as @exams' do
      exam = Exam.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:exams)).to eq([exam])
    end
  end

  describe '#show' do
    it 'assigns the requested exam as @exam' do
      exam = Exam.create! valid_attributes
      get :show, {id: exam.to_param}, valid_session
      expect(assigns(:exam)).to eq(exam)
    end
  end

  describe '#new' do
    it 'assigns a new exam as @exam' do
      get :new, {}, valid_session
      expect(assigns(:exam)).to be_a_new(Exam)
    end
  end

  describe '#edit' do
    it 'assigns the requested exam as @exam' do
      exam = Exam.create! valid_attributes
      get :edit, {id: exam.to_param}, valid_session
      expect(assigns(:exam)).to eq(exam)
    end
  end

  describe '#create' do
    describe 'with valid params' do
      it 'creates a new Exam' do
        expect do
          post :create, {exam: valid_attributes}, valid_session
        end.to change(Exam, :count).by(1)
      end

      it ' assigns a newly created exam as @exam' do
        post :create, {exam: valid_attributes}, valid_session
        expect(assigns(:exam)).to be_a(Exam)
        expect(assigns(:exam)).to be_persisted
      end

      it ' redirects to the created exam' do
        post :create, {exam: valid_attributes}, valid_session
        expect(response).to redirect_to(Exam.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved exam as @exam' do
        # Trigger the behavior that occurs when invalid params are submitted
        Exam.any_instance.stub(:save).and_return(false)
        post :create, {exam: {'language' => 'invalid value'}}, valid_session
        expect(assigns(:exam)).to be_a_new(Exam)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Exam.any_instance.stub(:save).and_return(false)
        post :create, {exam: {'language' => 'invalid value'}}, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe '#update' do
    describe 'with valid params' do
      it 'updates the requested exam' do
        exam = Exam.create! valid_attributes
        # Assuming there are no other exams in the database, this
        # specifies that the Exam created on the previous line
        # receives the :update message with whatever params are submitted in
        # the request.
        Exam.any_instance.should_receive(:update).with({'language' => ''})
        put :update, {id: exam.to_param, exam: {'language' => ''}}, valid_session
      end

      it ' assigns the requested exam as @exam' do
        exam = Exam.create! valid_attributes
        put :update, {id: exam.to_param, exam: valid_attributes}, valid_session
        expect(assigns(:exam)).to eq(exam)
      end

      it ' redirects to the exam' do
        exam = Exam.create! valid_attributes
        put :update, {id: exam.to_param, exam: valid_attributes}, valid_session
        expect(response).to redirect_to(exam)
      end
    end

    describe 'with invalid params' do
      it 'assigns the exam as @exam' do
        exam = Exam.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Exam.any_instance.stub(:save).and_return(false)
        put :update, {id: exam.to_param, exam: {'language' => 'invalid value'}}, valid_session
        expect(assigns(:exam)).to eq(exam)
      end

      it "re-renders the 'edit' template" do
        exam = Exam.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Exam.any_instance.stub(:save).and_return(false)
        put :update, {id: exam.to_param, exam: {'language' => 'invalid value'}}, valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested exam' do
      exam = Exam.create! valid_attributes
      expect do
        delete :destroy, {id: exam.to_param}, valid_session
      end.to change(Exam, :count).by(-1)
    end

    it ' redirects to the exams list' do
      exam = Exam.create! valid_attributes
      delete :destroy, {id: exam.to_param}, valid_session
      expect(response).to redirect_to(exams_url)
    end
  end

end
