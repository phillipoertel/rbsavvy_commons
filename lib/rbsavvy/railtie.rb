module RBSavvy
  class Engine < ::Rails::Railtie
    # Setup unified logging
    config.before_initialize  do |app|
      Rails.logger = app.config.logger = RBSavvy.logger
      config.log_level = RBSavvy::Logger::LOG_LEVEL

      app.config.middleware.delete(ActionDispatch::Cookies)
      app.config.middleware.delete(ActionDispatch::Session::CookieStore)
      app.config.middleware.insert_before(Rails::Rack::Logger, ActionDispatch::Session::CookieStore)
      app.config.middleware.insert_before(ActionDispatch::Session::CookieStore, ActionDispatch::Cookies)

      app.config.log_tags = [
        lambda { |req| req.session.id || "-" },
        :uuid
      ]

      app.config.lograge.enabled = RBSavvy::Logger::LOGRAGE_ENABLED
      app.config.lograge.custom_options = lambda do |event|
        params = event.payload[:params].reject { |key,_|
          RBSavvy::Logger::LOGRAGE_UNWANTED_PARAM_KEYS.include? key
        }

        Hash.new.tap do |payload|
          begin
            payload[:params] = params.to_json if params.present?
          rescue => e
            attempt ||= 1
            attempt += 1
            retry if attempt < 4
          end
        end
      end
    end


    # Setup Rollbar
    initializer 'rbsavvy_commons:rollbar' do
      require 'rollbar/rails'
      Rollbar.configure do |config|
        config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

        if Rails.env.test? || Rails.env.development?
          config.enabled = false
        end
      end
    end


    # Load rake tasks
    rake_tasks do
      load File.expand_path('../../tasks/help.rake', __FILE__)
      load File.expand_path('../../tasks/setup.rake', __FILE__)
      load File.expand_path('../../tasks/deploy.rake', __FILE__)

    end
  end
end

