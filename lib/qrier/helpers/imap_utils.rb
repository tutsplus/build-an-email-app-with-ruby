module Qrier
  ##
  # Abstracts away IMAP details in order to be used into more than one
  # component.
  #
  # It requires an `@imap` instance to be an instance of `Net::IMAP`.
  module IMAPUtils
    attr_reader :imap

    def address field
      field ? [ field.first.mailbox, '@', field.first.host ].join : nil
    end

    def fetch_emails recipient
      imap.examine recipient.to_s
      imap.search(['ALL']).each do |id|
        envelope = imap.fetch(id, 'ENVELOPE')[0].attr['ENVELOPE']
        uid      = imap.fetch id, 'UID'
        flags    = imap.fetch id, 'FLAGS'

        recipient.add_email Email.new(
          from:    address(envelope.from),
          to:      address(envelope.to),
          cc:      address(envelope.cc),
          bcc:     address(envelope.bcc),
          subject: envelope.subject,
          sent_at: Time.new(envelope.date),
          body:    imap.fetch(id, 'BODY[TEXT]')[0].attr['BODY[TEXT]'].force_encoding('utf-8'),
          new?:    !flags.include?(:Seen)
        )
      end
    end
  end
end
