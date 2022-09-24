require "rails_helper"

RSpec.describe "Signing in as a user", type: :system, js: true, use_chrome_headless: true do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context "success" do
    it "enable me to log in" do
      expect(page).to have_text("Log in")
    end
  end
end
