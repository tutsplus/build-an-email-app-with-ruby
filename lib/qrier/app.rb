module Qrier
  class App < Thor
    TEMPLATE_PATH = File.expand_path '../templates', __FILE__

    desc :list, 'Lists emails'
    def list
      service = ListFolders.new
      service.execute

      @folders = service.folders

      FolderRenderer.new(@folders).render
    end

    desc :send, 'Sends an email.'
    def send
      begin
      body = File.read(File.join(Dir.pwd, 'draft.txt'))
      to = ask('To? (separate by comma) ').split(',').map(&:strip)
      subject = ask('Subject? ').strip

      email_data = {
        to:      to,
        from:    Config::USER,
        subject: subject,
        body:    body
      }

      service = SendEmail.new email_data
      service.execute

      puts 'Email was sent.'

      rescue Errno::ENOENT => e
        puts "You haven't written your email. Create a draft.txt file first."
        exit 1
      end
    end

    desc :reply, 'Reply to an email.'
    def reply previous_message_id
      service = FetchEmails.new
      service.execute

      previous_email = service.emails.find { |email| email.message_id == previous_message_id }

      unless previous_email
        puts 'Invalid message id. Please use the `list` command to list your emails. Exiting.'
        exit 1
      end

      puts "Replying to #{previous_email.from}."

      subject = ask("Subject? (default: RE: #{previous_email.subject}) ") do |q|
        q.default = "RE: #{previous_email.subject}"
      end

      ask <<EOF
Please write the email's body into draft.txt. After that,
press Enter so it can be read and put into the email:
EOF

      send_service = SendEmail.new({
        to: [ previous_email.from ],
        subject: subject,
        body: File.read(File.join(Dir.pwd, 'draft.txt')),
      })

      send_service.execute

      puts "Email was sent."

    end

    private

    def render path
      template = ERB.new(File.read(File.join(TEMPLATE_PATH, "#{path}.erb")))
      puts template.result(binding)
    end
  end
end
