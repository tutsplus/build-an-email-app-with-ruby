module Qrier
  class FetchEmails
    include IMAPUtils

    def execute
      user = Config::USER
      password = Config::PASSWORD
      server = Config::IMAP_SERVER
      raise ArgumentError, 'Please provide your email credentials.' unless user && password

      @folder = Folder.new name: "INBOX"

      begin
        @imap = Net::IMAP.new server
        @imap.login user, password

        fetch_emails @folder
      ensure
        @imap.disconnect
      end
    end

    def emails
      @folder.emails
    end

  end
end
