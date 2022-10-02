require "rails_helper"

RSpec.describe "Sign up as a user", type: :system, js: true, use_chrome_headless: true do
  before do
    visit new_user_registration_path
  end

  context 'disallow' do
    it 'enable me to see user name input' do
      expect(page).to have_text('Sign up')

      within("#new_user") do
        expect(page).to have_selector('#user_name', visible: :visible)
      end
    end

    it 'enable me to see validations messages' do
      within("#new_user .actions") do
        find("input[type='submit']").click
      end

      expect(page).to have_current_path(new_user_registration_path)
      within("#error_explanation") do
        expect(page).to have_text("Email can't be blank")
        expect(page).to have_text("Name can't be blank")
        expect(page).to have_text("Password can't be blank")
      end
      expect(User.count).to eq(0)
    end
  end

  context 'allow' do
    context 'enable me to be registered' do
      it 'enable me to be redirected to root path' do
        within("#new_user") do
          fill_in "user_name", with: "User Name"
          fill_in "user_email", with: "some_email@gmail.com"
          fill_in "user_password", with: "some_email@gmail.com"
          fill_in "user_password_confirmation", with: "some_email@gmail.com"
          within(".actions") do
            find("input[type='submit']").click
          end
        end

        expect(page).to have_no_selector("#error_explanation", visible: true)
        expect(page).to have_current_path(root_path)
        expect(page).to have_text("Welcome! You have signed up successfully.")
        expect(User.count).to eq(1)
      end
    end
  end
end
