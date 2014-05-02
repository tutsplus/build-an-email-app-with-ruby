module Qrier
  class App < Thor
    TEMPLATE_PATH = File.expand_path "../templates", __FILE__

    desc :list, "Lists emails"
    def list
      @emails = Email.all
      render :list
    end

    private

    def render path
      template = ERB.new(File.read(File.join(TEMPLATE_PATH, "#{path}.erb")))
      puts template.result(binding)
    end
  end
end
