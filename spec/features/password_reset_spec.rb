require 'spec_helper'

feature 'Password Reset' do
  background do
    clear_emails
    @user = create(:user)
    @user.confirm!

    visit new_user_session_path
    click_link 'Forgot your password?'

    fill_in 'Email', with: @user.email
    click_button 'Send me reset password instructions'

    @user.reload
  end

  after do
    @user.destroy
  end

  scenario 'displays a message about the password reset email' do
    expect(page).to have_content I18n.t('devise.passwords.send_instructions')
    expect(current_path).to eq new_user_session_path
  end

  scenario 'sends a password reset email with url' do
    expect(open_email(@user.email)).to_not be_nil
    expect(current_email.body).to match "#{edit_user_password_path}\\?reset_password_token=#{@user.reset_password_token}"
  end

  scenario 'resets the password' do
    visit "#{edit_user_password_path}?reset_password_token=#{@user.reset_password_token}"

    fill_in 'New password', with: 'som3_g00d_p@ssword'
    fill_in 'Confirm your new password', with: 'som3_g00d_p@ssword'
    click_button 'Change my password'

    expect(page).to have_content 'Your password was changed successfully'
    expect(current_path).to eq root_path
  end
end
