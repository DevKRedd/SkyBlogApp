require "capybara/rspec"

Capybara.register_driver :chrome_headless do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      "goog:chromeOptions" => {
        "args" => %w[headless disable-gpu no-sandbox window-size=1400,1400 disable-dev-shm-usage]
      }
    )
  )
end

Capybara.javascript_driver = :chrome_headless
Capybara.default_max_wait_time = 5
