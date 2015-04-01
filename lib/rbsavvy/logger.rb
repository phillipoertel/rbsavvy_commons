require 'active_support'
require 'active_support/core_ext'

class RBSavvy::Logger < ::Logger
  DATETIME_FORMAT = "%Y-%m-%d %I:%M:%S.%6N %z"
  LOG_FORMAT      = "%s %5s [PID-%s] [TID-%s] %s\n"

  LOG_FORMATTER   = ->(severity, datetime, progname, msg) {
    LOG_FORMAT % [
      datetime.strftime(DATETIME_FORMAT),
      severity,
      Process.pid,
      Thread.current.object_id.to_s(36),
      msg
    ]
  }

  LOGRAGE_UNWANTED_PARAM_KEYS = %w[format action controller]
  LOGRAGE_ENABLED = (ENV['LOGRAGE'] || 'true') == 'true'


  VALID_LOG_LEVELS = %w[DEBUG INFO WARN ERROR FATAL UNKNOWN]
  LOG_LEVEL = ::Logger.const_get(([ENV['LOG_LEVEL'].to_s.upcase, "INFO"] & VALID_LOG_LEVELS ).compact.first)

  OUTPUT = ENV['LOG_OUTPUT'].blank? || ENV['LOG_OUTPUT'] == 'STDOUT' ? STDOUT : File.open(ENV['LOG_OUTPUT'], 'w')
  OUTPUT.sync = true

  def initialize
    super OUTPUT
    self.formatter = LOG_FORMATTER
    self.level     = LOG_LEVEL

    info "logger initialized (level: #{VALID_LOG_LEVELS[self.level]}, lograge: #{LOGRAGE_ENABLED})"
  end

  # Don't let rails add broadcasts! Prevents log output duplication
  def extend(mod)
    super(mod) if mod == ActiveSupport::TaggedLogging
  end
end