module Qrier
  class Folder
    attr_reader :name

    def initialize options
      @name = options[:name]
    end

    def emails
      @emails ||= []
    end

    def to_s
      name
    end

    def add_email email
      emails << email
    end

    def emails_hash
      emails.map do |email|
        {
          from: email.from,
          to: email.to.is_a?(String) ? email.to : email.to.join(", "),
          subject: email.subject,
          sent_at: email.sent_at,
          new?: email.new?,
          body: email.body,
          uid: email.uid,
          message_id: email.message_id
        }
      end
    end
  end
end
