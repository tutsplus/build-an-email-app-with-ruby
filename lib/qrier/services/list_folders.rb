module Qrier
  class ListFolders
    attr_reader :folders

    def folders
      @folders ||= []
    end

    def execute
      begin
        imap = Net::IMAP.new 'mail.josemota.net'
        imap.login ENV['QRIER_USER'], ENV['QRIER_PWD']
        list = imap.list "*", "*"
        list.each do |item|
          folder = Folder.new name: item.name
          folders << folder

          imap.examine folder.name
          imap.search(["ALL"]).each do |id|
            envelope = imap.fetch(id, 'ENVELOPE')[0].attr['ENVELOPE']
            uid = imap.fetch id, 'UID'
            flags = imap.fetch id, 'FLAGS'

            folder.add_email Email.new(
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
