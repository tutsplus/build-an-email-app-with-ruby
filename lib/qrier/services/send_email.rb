module Qrier
  class SendEmail
    attr_reader :email
    def initialize email_data
      @smtp_server = Config::SMTP_SERVER
      @imap_server = Config::IMAP_SERVER
      @user = Config::USER
      @password = Config::PASSWORD
      @sent_folder = Config::SENT_FOLDER

      setup_email email_data
    end

    def execute
      add_metadata_to_email

      smtp = Net::SMTP.new @smtp_server
      smtp.start @smtp_server, @user, @password, :login
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
      imap = Net::IMAP.new @imap_server
      imap.login @user, @password

      imap.append @sent_folder, message, [:Seen], Time.now
      ensure
        imap.disconnect
    end

    def add_metadata_to_email
      email.update_timestamp
    end

    def message
      string = <<EOF
From: #{email.from}
To: #{email.to.join ', '}
Subject: #{email.subject}
Date: #{email.sent_at}

#{email.body}
EOF

    string.gsub("\n", "\r\n")
    end
  end
end
