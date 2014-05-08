module Qrier
  class ReplyToEmail
    def initialize previous_message_id
      @previous_message_id = previous_message_id
    end

    def execute
      find_email
      ask_for_data
      send_reply
    end

    private

    attr_reader :previous_message_id, :previous_email, :subject

    def find_email
      service = FetchEmails.new
      service.execute

      @previous_email = service.emails.find { |email| email.message_id == previous_message_id }

      unless previous_email
        puts 'Invalid message id. Please use the `list` command to list your emails. Exiting.'
        exit 1
      end

      puts "Replying to #{previous_email.from}."
    end

    def ask_for_data
      @subject = ask("Subject? ") do |q|
        q.default = "RE: #{previous_email.subject}"
      end

      ask <<EOF
Please write the email's body into draft.txt. After that,
press Enter so it can be read and put into the email:
EOF
    end

    def send_reply
      send_service = SendEmail.new({
        to: [ previous_email.from ],
        subject: subject,
        body: File.read(File.join(Dir.pwd, 'draft.txt')),
      })

      send_service.execute
    end
  end
end
