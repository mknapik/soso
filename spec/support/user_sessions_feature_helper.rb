module UserSessionsFeatureHelper

  def sign_in(email, password)
    visit new_user_session_path

    within('#new_user_session') do
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_on 'Sign In'
    end
  end

  def sign_out
    visit destroy_user_session_path
  end

end

RSpec.configure do |config|
  config.include UserSessionsFeatureHelper, type: :feature
end
