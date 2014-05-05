module Qrier
  class FetchEmails
    include IMAPUtils

    def execute
      user = ENV['QRIER_USER']
      password = ENV['QRIER_PWD']
      raise ArgumentError, 'Please provide your email credentials.' unless user && password

      @folder = Folder.new name: "INBOX"

      begin
        @imap = Net::IMAP.new 'mail.josemota.net'
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
