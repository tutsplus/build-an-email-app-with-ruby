require 'test_helper'
require 'net/smtp'
require 'qrier/models/email'
require 'qrier/services/send_email'

module Qrier
  class SendEmailTest < MiniTest::Test
    include Helpers::Fixtures

    def self.init
      @folders_service = ListFolders.new
      @folders_service.execute

      @@sent_messages_count_before = email_count 'INBOX.Sent'

      email_data = {
        to:      [ "jose@josemota.net" ],
        subject: "Hello from Qrier!",
        body:    File.read(File.join(FIXTURES_PATH, 'email_body.txt'))
      }

      @@service = SendEmail.new email_data
      @@service.execute

      @folders_service.clean.execute
      @@sent_messages_count_after = email_count 'INBOX.Sent'
    end

    def self.email_count mailbox
      @folders_service.folders.find do |f|
        f.name == mailbox
      end.emails.size
    end

    init

    def test_sends_email
      assert_equal Time.now.year, @@service.email.sent_at.year
    end

    def test_keeps_a_copy_in_the_sent_folder
      assert_equal 1, @@sent_messages_count_after - @@sent_messages_count_before
    end

  end
end
