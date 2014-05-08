module Qrier
  class Setup
    def execute
      ask_for_data
      save
      load_config
      ask_for_sent_folder
      save # in order to store the sent folder
    end

    private

    def ask_for_data
      @user        = ask("What's your email address? ")
      domain       = @user.split('@').last
      @password    = ask("Type in your password: ") { |q| q.echo = "*" }
      @imap_server = ask("Where is the IMAP server? ") { |q| q.default = "imap.#{domain}" }
      @smtp_server = ask("And the SMTP server? ") { |q| q.default = "smtp.#{domain}" }
    end

    def ask_for_sent_folder
      service = ListFolders.new
      service.execute

      folders = service.folders.map(&:name)
      say folders.join "\n"
      @sent_folder = ask 'Select your sent folder: ', folders
    end

    def save
      template = ERB.new(File.read(File.join(App::TEMPLATE_PATH, "qrier.yml.erb")))
      content = template.result(binding)

      File.open(File.join(Dir.home, '.qrier.yml'), "w") do |file|
        file.write content
      end
    end

    def load_config
      Config.reload
    end
  end
end
