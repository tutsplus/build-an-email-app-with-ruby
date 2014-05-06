require "yaml"

module Qrier
  module Config
    def self.load
      yaml = YAML.load_file File.join(Dir.home, '.qrier.yml')
      const_set(:USER, yaml['user'])
      const_set(:PASSWORD, yaml['password'])
      const_set(:IMAP_SERVER, yaml['imap_server'])
      const_set(:SMTP_SERVER, yaml['smtp_server'])
      const_set(:SENT_FOLDER, yaml['sent_folder'])
    end

  end
end
