require 'rails_helper'

RSpec.describe 'User log out feature' do
  it 'can log out' do
    @user_1 = create(:user)
    visit landing_page_path

    click_link "Log In"
    expect(current_path).to eq(login_path)

    fill_in 'email', with: @user_1.email
    fill_in "password", with: @user_1.password
    click_button "Log In"

    visit landing_page_path
    expect(page).to_not have_content("Log In")
    expect(page).to_not have_content("Create Account")
    expect(page).to have_content("Log Out")

    click_link "Log Out"
    expect(current_path).to eq(landing_page_path)
    expect(page).to have_content("Log In")
    expect(page).to_not have_content("Log Out")
  end
end