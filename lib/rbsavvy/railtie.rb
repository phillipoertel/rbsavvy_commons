module RBSavvy
  class Engine < ::Rails::Railtie
    config.before_initialize  do |app|
      Rails.logger = app.config.logger = RBSavvy.logger
      config.log_level = RBSavvy::Logger::LOG_LEVEL

      app.config.log_tags = [
        :uuid
      ]

      app.config.lograge.enabled = RBSavvy::Logger::LOGRAGE_ENABLED
      app.config.lograge.custom_options = lambda do |event|
        params = event.payload[:params].reject { |key,_|
          RBSavvy::Logger::LOGRAGE_UNWANTED_PARAM_KEYS.include? key
        }
        Hash.new.tap do |payload|
          payload[:params] = params.to_json if params.present?
        end
      end
    end

    rake_tasks do
      load File.expand_path('../../tasks/help.rake', __FILE__)
    end
  end
end

