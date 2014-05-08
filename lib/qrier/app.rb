require "highline/import"

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
      service = ReplyToEmail.new previous_message_id
      service.execute

      puts "Email was sent."
    end

    desc :setup, 'Bootstrap configration to use with Qrier.'
    def setup
      Setup.new.execute
    end

    private

    def render path
      template = ERB.new(File.read(File.join(TEMPLATE_PATH, "#{path}.erb")))
      puts template.result(binding)
    end
  end
end
