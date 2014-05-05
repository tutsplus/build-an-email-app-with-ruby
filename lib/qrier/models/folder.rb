module Qrier
  class Folder
    attr_reader :name

    def initialize options
      @name = options[:name]
    end

    def emails
      @emails ||= []
    end

    def add_email email
      emails << email
    end
  end
end
