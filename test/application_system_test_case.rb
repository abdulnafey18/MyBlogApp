require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

    # Point Capybara to your React app
    Capybara.app_host = "http://localhost:3000" # Adjust if React is running on a different port
end
