module Qrier
  class Setup
    def execute
      @user        = ask("What's your email address? ")
      domain       = @user.split('@').last
      @password    = ask("Type in your password: ") { |q| q.echo = "*" }
      @imap_server = ask("Where is the IMAP server? ") { |q| q.default = "imap.#{domain}" }
      @smtp_server = ask("And the SMTP server? ") { |q| q.default = "smtp.#{domain}" }

      template = ERB.new(File.read(File.join(App::TEMPLATE_PATH, "qrier.yml.erb")))
      content = template.result(binding)
      File.open(File.join(Dir.home, '.qrier.yml'), "w") do |file|
        file.write content
      end
    end
  end
end
