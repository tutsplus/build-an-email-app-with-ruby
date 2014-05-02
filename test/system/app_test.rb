require "test_helper"
require "qrier"

module Qrier
  class AppTest < Minitest::Test
    include Helpers::Fixtures

    def test_lists_emails
      emails = fixtures :email

      Email.stub :all, emails do
        output, err = capture_io { App.start %w(list) }
        assert_includes output, "jose@josemota.net"
      end
    end
  end
end
