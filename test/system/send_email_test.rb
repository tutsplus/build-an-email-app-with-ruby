require 'test_helper'
require 'net/smtp'
require 'qrier/models/email'
require 'qrier/services/send_email'

module Qrier
  class SendEmailTest < MiniTest::Test
    include Helpers::Fixtures
    def test_sends_email
      email_data = {
        to:      [ "jose@josemota.net" ],
        subject: "Hello from Qrier!",
        body:    File.read(File.join(FIXTURES_PATH, 'email_body.txt'))
      }

      service = SendEmail.new email_data
      service.execute

      assert_equal Time.now.year, service.email.sent_at.year
    end
  end
end
