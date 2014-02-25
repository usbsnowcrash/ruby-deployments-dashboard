module BrowserExtensions
  def self.setup_geolocation_support
    Capybara.register_driver :poltergeist do |app|
      extension_files = Dir[Rails.root.join("spec/support/browser_extensions/**/*.js")]
      Capybara::Poltergeist::Driver.new app, extensions: extension_files
    end 
  end
end