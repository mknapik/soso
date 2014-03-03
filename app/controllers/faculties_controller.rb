class FacultiesController < ApplicationController
  def field_of_studies
    faculty = Faculty.find(params[:faculty_id])
    access_denied! 'cannot.view.faculty' if cannot? :read, faculty

    field_of_studies = [['', '']]
    unless params[:faculty_id] == 0
      field_of_studies += FieldOfStudy.where(faculty_id: params[:faculty_id]).map do |field_of_study|
        [field_of_study.id, field_of_study.name]
      end
    end

    respond_to do |format|
      format.json { render json: field_of_studies }
    end
  end

  def specializations
    field_of_study = FieldOfStudy.find(params[:field_of_study_id])
    access_denied! 'cannot.view.field_of_study' if cannot? :read, field_of_study

    specializations = [['', '']]
    unless params[:field_of_study_id] == 0
      specializations += Specialization.where(field_of_study_id: params[:field_of_study_id]).map do |specialization|
        [specialization.id, specialization.name]
      end
    end

    respond_to do |format|
      format.json { render json: specializations }
    end
  end
end