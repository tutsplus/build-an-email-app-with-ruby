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
      smtp = Net::SMTP.new @server

      smtp.start @server, @user, @password, :login
      smtp.send_message message, email.from, email.to

      add_metadata_to_email
    ensure
      smtp.finish
    end

    private

    def setup_email data
      data = data.merge({ from: @user })
      @email = Email.new data
    end

    def add_metadata_to_email
      email.update_timestamp
    end

    def message
      <<EOF
From: #{email.from}
To: #{email.to.join ', '}
Subject: #{email.subject}

#{email.body}
EOF
    end
  end
end
