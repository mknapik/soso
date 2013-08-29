class UserProfileForm
  attr_accessor :params

  def initialize(params)
    attributes = [
        :name, :surname, :email,
        :faculty_id, :field_of_study_id, :specialization_id,
        :student_no, :study_year, :street, :house, :city, :zip, :phone, :birth_date,
        {:sector_ids => []}, :current_password]

    user_params = params.require(:user)

    self.params = user_params.permit(attributes)
  end
end