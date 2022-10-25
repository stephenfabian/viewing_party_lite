# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'landing page' do
  # When a user visits the root path they should be on the landing page ('/') which includes:

  # Title of Application
  # Button to Create a New User
  # List of Existing Users which links to the users dashboard
  # Link to go back to the landing page (this link will be present at the top of all pages)

  describe 'Landing Page User Story' do
    before :each do
      @user_1 = create(:user)
      @user_2 = create(:user)
      @user_3 = create(:user)
    end
    # it 'When a user visits the root path they should be on the landing page and user name is link to user dashboard' do
    #   visit landing_page_path

    #   expect(page).to have_content('Viewing Party Lite')
    #   click_link @user_1.name.to_s
    #   expect(current_path).to eq(user_path(@user_1))

    #   visit landing_page_path

    #   click_link @user_2.name.to_s
    #   expect(current_path).to eq(user_path(@user_2))

    #   visit landing_page_path

    #   click_link @user_3.name.to_s
    #   expect(current_path).to eq(user_path(@user_3))
    # end

    it 'has button to create new user and landing page link on all pages' do
      visit landing_page_path

      click_button 'Create New User'

      expect(current_path).to eq(register_path)

      click_link 'Landing Page'
      expect(current_path).to eq(landing_page_path)
    end

    it 'When I visit the landing page I do not see the section of the page that lists existing users' do
        visit landing_page_path
        expect(page).to_not have_content("Current Users")
    end

    it 'As a visitor, When I visit the landing page, And then try to visit /dashboard
    I remain on the landing page
    And I see a message telling me that I must be logged in or registered to access my dashboard' do
         visit landing_page_path
         visit dashboard_path

         expect(current_path).to eq(landing_page_path)
         expect(page).to have_content("You must be logged in or registered to access your dashboard")
    end

    it 'must be logged in or registered to create a movie party, else flash message', :vcr do 
      @movie1 = MovieFacade.details_poro(550)

      visit "/movies/#{@movie1.id}"
      click_button "Create Viewing Party"
      expect(current_path).to eq("/movies/#{@movie1.id}")
      expect(page).to have_content("You must be logged in or registered to create a viewing party")

  end
end
end