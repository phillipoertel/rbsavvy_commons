module RBSavvy
  class Engine < ::Rails::Railtie
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
          payload[:params] = params.to_json if params.present?
        end
      end
    end

    rake_tasks do
      load File.expand_path('../../tasks/help.rake', __FILE__)
      load File.expand_path('../../tasks/setup.rake', __FILE__)
      load File.expand_path('../../tasks/deploy.rake', __FILE__)

    end
  end
end

