require 'spec_helper'

feature 'Activation' do
  scenario 'with a valid token should activate the user and sign them in' do
    @user = create(:user)
    visit user_confirmation_path(confirmation_token: @user.confirmation_token)

    expect(current_path).to eq root_path
    expect(page).to have_content I18n.t('devise.confirmations.confirmed')
  end

  scenario 'with an invalid token should send the user to sign in' do
    visit user_confirmation_path(confirmation_token: 'BOGUS')

    expect(current_path).to eq user_confirmation_path
    expect(page).to have_content 'Confirmation token is invalid'
  end
end
