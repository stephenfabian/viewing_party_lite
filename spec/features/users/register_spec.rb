# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User Registration page' do
  before :each do
    @user_1 = create(:user)
    @user_2 = create(:user)
  end
  # When a user visits the '/register' path they should see a form to register.

  # The form should include:

  # Name
  # Email (must be unique)
  # Register Button
  # Once the user registers they should be taken to a dashboard page '/users/:id', where :id is the id for the user that was just created.

  describe 'User Registration Page #5' do
    it 'When a user visits the register path they should see a form to register.' do
      visit register_path

      fill_in 'name', with: 'James Dean'
      fill_in 'email', with: 'jimmydean1979@goodinternet.net'
      fill_in 'password', with: 'Tommy123'
      fill_in 'password_confirmation', with: 'Tommy123'

      click_on 'Save'

      user = User.last
      allow_any_instance_of(ApplicationController).to receive(:user_id_in_session).and_return(User.last.id)

      expect(current_path).to eq(dashboard_path)
    end

    it 'has happy path' do
      visit register_path

      fill_in 'name', with: 'James Dean'
      fill_in 'email', with: 'jimmydean1979@goodinternet.net'
      fill_in 'password', with: 'Tommy123'
      fill_in 'password_confirmation', with: 'Tommy123'

      click_on 'Save'

      expect(page).to have_content('User Registered Successfully')
    end

    it 'User Story #2 - Registration (w/ Authentication) Sad Path' do
      visit register_path

      click_on 'Save'

      expect(page).to have_content("Name can't be blank, Email can't be blank, Password digest can't be blank, and Password can't be blank")
    end

    describe 'User Story #3 - Logging In Happy Path' do
     it 'When I visit the landing page `/`, I see a link for "Log In' do
      visit landing_page_path

      click_link "Log In"
      expect(current_path).to eq(login_path)

      fill_in 'email', with: @user_1.email
      fill_in "password", with: @user_1.password
      click_button "Log In"

      expect(current_path).to eq(dashboard_path)
     end
    end

    describe 'User Story #4 - Logging in Sad Path' do
      it 'if logging in and I fail to fill_in correct credentials,
       taken back to login page and see flash message telling me I entered incorrect creds' do

        visit landing_page_path

        click_link "Log In" 

        fill_in 'email', with: "yo"
        fill_in "password", with: "yo"
        click_button "Log In"
        expect(current_path).to eq(login_path)
    
        expect(page).to have_content("Sorry, your credentials are bad.")
       end
    end
  end
end
