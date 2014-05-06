module Qrier
  class ListFolders
    include IMAPUtils

    def execute
      user = Config::USER
      password = Config::PASSWORD
      server = Config::IMAP_SERVER
      raise ArgumentError, 'Please provide your email credentials.' unless user && password

      begin
        @imap = Net::IMAP.new server
        @imap.login user, password
        list = imap.list '*', '*'
        list.each do |item|
          folder = Folder.new name: item.name
          folders << folder

          fetch_emails folder
        end

      ensure
        @imap.disconnect
      end
    end

    def folders
      @folders ||= []
    end

    def clean
      @folders.clear
      self
    end

  end
end
