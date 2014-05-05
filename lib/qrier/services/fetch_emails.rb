module Qrier
  class FetchEmails
    def emails
      @emails ||= []
    end

    def execute
      user = ENV['QRIER_USER']
      password = ENV['QRIER_PWD']
      raise ArgumentError, "Please provide your email credentials." unless user && password

      begin
        imap = Net::IMAP.new 'mail.josemota.net'
        imap.login user, password
        imap.examine 'INBOX'
        imap.search(['ALL']).each do |id|
          envelope = imap.fetch(id, 'ENVELOPE')[0].attr['ENVELOPE']
          uid = imap.fetch id, 'UID'
          flags = imap.fetch id, 'FLAGS'

          emails << Email.new(
            from:    address(envelope.from),
            to:      address(envelope.to),
            cc:      address(envelope.cc),
            bcc:     address(envelope.bcc),
            subject: envelope.subject,
            sent_at: Time.new(envelope.date),
            body:    imap.fetch(id, 'BODY[TEXT]')[0].attr['BODY[TEXT]'].force_encoding("utf-8"),
            new?:    !flags.include?(:Seen)
          )
        end
      ensure
        imap.close
      end
    end

    def address field
      field ? [ field.first.mailbox, '@', field.first.host ].join : nil
    end
  end
end