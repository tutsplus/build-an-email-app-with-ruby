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

      @flags = []
      @flags << :new if options[:new?]

      # @folder?
    end

    def self.all
      
    end

    def new?
      @flags.include? :new
    end
  end
end
