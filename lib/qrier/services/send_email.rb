module Qrier
  class SendEmail
    attr_reader :email
    def initialize email_data
      @server = 'mail.josemota.net'
      @user = ENV['QRIER_USER']
      @password = ENV['QRIER_PWD']

      setup_email email_data
    end

    def execute
      add_metadata_to_email

      smtp = Net::SMTP.new @server
      smtp.start @server, @user, @password, :login
      smtp.send_message message, email.from, email.to
      smtp.finish

      store_mail
    end

    private

    def setup_email data
      data = data.merge({ from: @user })
      @email = Email.new data
    end

    def store_mail
      imap = Net::IMAP.new 'mail.josemota.net'
      imap.login @user, @password

      imap.append 'INBOX.Sent', <<EOF.gsub("\n", "\r\n"), [:Seen], Time.now
Subject: #{@email.subject}
From: #{@email.from}
To: #{@email.to.join ', '}
Date: #{@email.sent_at}

#{@email.body}
EOF
      ensure
        imap.disconnect
    end

    def add_metadata_to_email
      email.update_timestamp
    end

    def message
      <<EOF
From: #{email.from}
To: #{email.to.join ', '}
Subject: #{email.subject}
Date: #{email.sent_at}

#{email.body}
EOF
    end
  end
end
