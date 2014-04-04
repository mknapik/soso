class UserProfileForm
  attr_accessor :params
  attr_accessor :model

  def initialize(model, params)
    attributes = [
        :name, :surname, :email,
        :faculty_id, :field_of_study_id, :specialization_id,
        :student_no, :study_year, :street, :house, :city, :zip, :phone, :birth_date,
        {sector_ids: []}, :current_password]
    user_params = params.require(:user).permit(attributes)
    sector_ids = user_params.delete(:sector_ids)
    self.model = model
    self.model.assign_attributes(user_params)
    self.model.sector_ids = sector_ids
  end

  def edit_profile
    return false unless model.valid?
    model.edit_profile
  end

  alias_method :save, :edit_profile
  alias_method :fill_data, :edit_profile
end
