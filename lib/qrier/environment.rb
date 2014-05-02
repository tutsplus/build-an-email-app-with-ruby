module Qrier
  def self.environment
    ENV['APP_ENV'].to_sym || :development
  end
end
