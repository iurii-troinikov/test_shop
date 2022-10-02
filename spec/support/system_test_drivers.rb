# frozen_string_literal: true

module SystemTestDrivers
  def use_chrome
    Capybara.register_driver :selenium_chrome do |app|
      Capybara::Selenium::Driver.load_selenium
      browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        opts.args << '--window-size=1920,1080'
        opts.args << '--disable-site-isolation-trials'
      end
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
    end
    driven_by :selenium_chrome
  end

  def use_chrome_headless
    Capybara.register_driver :selenium_chrome_headless do |app|
      Capybara::Selenium::Driver.load_selenium
      browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
        opts.args << '--window-size=1920,1080'
        opts.args << '--headless'
        opts.args << '--disable-gpu' if Gem.win_platform?
        opts.args << '--disable-site-isolation-trials'
      end
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
    end
    driven_by :selenium_chrome_headless
  end

  # IPhone 8
  def resize_window_to_mobile
    resize_window_by(750, 1334)
  end

  # Full HD
  def resize_window_default
    resize_window_by(1920, 1080)
  end

  private

  def resize_window_by(width, height)
    page.driver.browser.manage.window.resize_to(width, height)
  end
end

RSpec.configure do |config|
  config.include SystemTestDrivers

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    use_chrome_headless
  end
end
