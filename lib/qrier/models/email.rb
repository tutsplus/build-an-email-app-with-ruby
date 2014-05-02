module Qrier
  class Email
    attr_reader :from, :to, :cc, :bcc, :body, :subject, :sent_at

    def initialize options
      @from    = options[:from]
      @to      = options[:to]
      @cc      = options[:cc]
      @bcc     = options[:bcc]
      @body    = options[:body]
      @subject = options[:subject]
      @sent_at = options[:sent_at]

      # @folder?
    end

    def self.all
      
    end
  end
end
