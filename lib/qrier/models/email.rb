module Qrier
  class Email
    attr_reader :from, :to, :cc, :bcc, :body, :subject, :sent_at, :uid, :message_id

    def initialize options
      @from       = options[:from]
      @to         = options[:to]
      @cc         = options[:cc]
      @bcc        = options[:bcc]
      @body       = options[:body]
      @subject    = options[:subject]
      @sent_at    = options[:sent_at]
      @uid        = options[:uid]
      @message_id = options[:message_id]

      @flags = []
      @flags << :new if options[:new?]

      # @folder?
    end

    def new?
      @flags.include? :new
    end

    def update_timestamp
      @sent_at = Time.now
    end

    def set_message_id
      @message_id = Digest::SHA1.hexdigest [ @sent_at, @subject, @body ].join
    end
  end
end
