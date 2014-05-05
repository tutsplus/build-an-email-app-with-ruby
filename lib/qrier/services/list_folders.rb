module Qrier
  class ListFolders
    include IMAPUtils

    def execute
      user = ENV['QRIER_USER']
      password = ENV['QRIER_PWD']
      server = 'mail.josemota.net'
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

  end
end
