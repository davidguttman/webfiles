# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Webfiles::Application.initialize!

begin
  PATH_CONFIG = YAML.load_file Rails.root.to_s + '/config/directories.yml'
rescue => e
  puts e
  raise "Error loading config/directories.yml. Did you copy config/directories.yml.template?"
end