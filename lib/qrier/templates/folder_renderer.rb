module Qrier
  class FolderRenderer
    def initialize folders
      @folders = folders
    end

    def render
      @folders.each do |folder|
        puts folder.name.colorize :green
        puts '='.colorize(:green) * folder.name.size + "\n"

        if folder.emails.any?
          Formatador.display_table folder.emails_hash, [ :new?, :uid, :message_id, :from, :subject, :sent_at ]
        else
          puts "No emails.".colorize :yellow
        end
        puts
      end
    end

  end
end
