module Qrier
  class FetchEmails
    include IMAPUtils

    def execute
      user = ENV['QRIER_USER']
      password = ENV['QRIER_PWD']
      raise ArgumentError, 'Please provide your email credentials.' unless user && password

      begin
        @imap = Net::IMAP.new 'mail.josemota.net'
        @imap.login user, password

        fetch_emails self
      ensure
        @imap.disconnect
      end
    end

    def emails
      @emails ||= []
    end

    def to_s
      'INBOX'
    end

    def add_email email
      emails << email
    end

  end
end
