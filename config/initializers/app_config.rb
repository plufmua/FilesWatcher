require 'yaml'

APP_CONFIG = YAML.load_file(Rails.root.join('config/files_watcher.yml'))[Rails.env]